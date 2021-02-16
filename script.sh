#!/bin/sh

docker run -e REPO_OWNER=$1 -e REPO_NAME=$2 -e GITHUB_OAUTH_TOKEN=$3 -v `pwd`:/files supratim4persistent/terraform-module-version-checker:v1
