#!/bin/bash

pipenv run pip install -r <(pipenv lock -r) --target dist/

