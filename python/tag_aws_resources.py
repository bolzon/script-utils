#!/bin/pyrhon3

import json
import logging
import os

import boto3

logger = logging.getLogger(__name__)
logger.setLevel(os.getenv('LOG_LEVEL', 'INFO'))

TAGS = {'owner': 'me'}


def tag_default_resources_handler(event: dict[str, object], _: object) -> None:
    """
    This handler is supposed to automatically handle AWS events configured to notify
    non-tagged resources according to the "required-tags" rule in AWS Config.
    """
    config_client = boto3.client('config')
    rgt_client = boto3.client('resourcegroupstaggingapi')

    resource_id = event['ResourceId']
    expr = f"select arn where resourceId = '{resource_id}'"
    logger.debug(expr)

    results = config_client.select_resource_config(Expression=expr, Limit=100)
    arns = [json.loads(result)['arn'] for result in results['Results']]
    logger.debug(arns)

    response = rgt_client.tag_resources(ResourceARNList=arns[:20], Tags=event['RequiredTags'])
    return {
        'SuccessesResources': [],
        'FailedResources': response['FailedResourcesMap'],
    }


def main() -> None:
    """
    Routine to list non-compliant resources using AWS Config API and tag each of them.
    Tagging permissions are required to execute this task.
        - tag:TagResource
        - ec2:CreateTags
    See more at:
        https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/API_TagResources.html
    """
    args = {}
    config_client = boto3.client('config')
    rgt_client = boto3.client('resourcegroupstaggingapi')

    while True:
        response = config_client.get_compliance_details_by_config_rule(
            ConfigRuleName='required-tags',
            ComplianceTypes=['NON_COMPLIANT'],
            Limit=100,
            **args,
        )

        if results := response.get('EvaluationResults'):
            results = [result['EvaluationResultIdentifier']['EvaluationResultQualifier'] for result in results]
            resources = [[result['ResourceId'], result['ResourceType']] for result in results]

            resource_ids, resource_types = list(zip(*[[f"'{res[0]}'", f"'{res[1]}'"] for res in resources], strict=False))
            expr = f"select arn where resourceType in ({', '.join(resource_types)}) and resourceId in ({', '.join(resource_ids)})"
            logger.debug(expr)

            results = config_client.select_resource_config(Expression=expr, Limit=100)
            arns = [json.loads(result)['arn'] for result in results['Results']]
            logger.debug(arns)

            while len(arns):
                rgt_client.tag_resources(ResourceARNList=arns[:20], Tags=TAGS)
                arns = arns[:20]

        if next_token := response.get('NextToken'):
            args['NextToken'] = next_token
        else:
            break


if __name__ == '__main__':
    try:
        main()
    except Exception as ex:
        print(ex)
