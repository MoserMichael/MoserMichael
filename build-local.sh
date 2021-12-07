#!/bin/bash 

set -ex

if [[ "x$GITHUB_TOKEN" == "x" ]]; then
    echo "Error: GITHUB_TOKEN not set"
    exit 1
fi
if [[ "x$GITHUB_USER" == "x" ]]; then
    echo "Error: GITHUB_USER not set"
    exit 1
fi    

THIS_REPO=https://github.com/MoserMichael/MoseMichael.git

docker build -t ci-build-gpage:0.0.1 .

docker run  -t -e USER_REPO=$THIS_REPO -e GITHUB_USER=$GITHUB_USER -e GITHUB_TOKEN=$GITHUB_TOKEN  ci-build-gpage:0.0.1 ./build.sh

#docker run  -ti -e USER_REPO=https://github.com/MoserMichael/MoseMichael.git -e GITHUB_USER=$GITHUB_USER -e GITHUB_TOKEN=$GITHUB_TOKEN  ci-build-gpage:0.0.1 bash

