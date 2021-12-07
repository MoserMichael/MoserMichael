#!/bin/bash
if [[ "x$GITHUB_TOKEN" == "x" ]]; then
    echo "Error: GITHUB_TOKEN not set"
    exit 1
fi
if [[ "x$GIHTUB_USER" == "x' ]]; then
    echo "Error: GITHUB_USER not set"
    exit 1
fi    

docker build -t ci-build-gpage
docker run -t ci-build-gpage -e GITHUB_USER=$GITHUB_USER GITHUB_TOKEN=$GITHUB_TOKEN
