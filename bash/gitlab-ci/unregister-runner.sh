#!/bin/bash

# remove a runner
gitlab-runner unregister -t <token> -u <url>

# sometimes the first one does not work, so you can try
gitlab-runner verify --delete -t <token> -u <url>
