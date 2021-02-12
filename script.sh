#!/bin/sh

REPO_OWNER=$1
REPO_NAME=$2
GITHUB_OAUTH_TOKEN=$3
docker run -e REPO_OWNER=$REPO_OWNER -e REPO_NAME=$REPO_NAME -e GITHUB_OAUTH_TOKEN=$GITHUB_OAUTH_TOKEN -v `pwd`:/files supratim4persistent/terraform-module-version-checker:v1
