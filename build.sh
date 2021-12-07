#!/bin/bash

set -ex

cd / 

# checkout all used repositories
git clone https://github.com/MoserMichael/opinionated-fortune-cow  cows
git clone https://github.com/MoserMichael/githubapitools 
git clone https://github.com/MoserMichael/MoseMichael.git gh-page

cat start_part.txt > README.md

pushd cows
./cows.sh >>../README.md
popd

cat common_part.txt >>README.md

if [[ -z $GITHUB_TOKEN ]]; then
    echo "token does not exist, can't upload and can't count stars"
    exit 1
fi

pushd githubapitools
pip3 install requirements.txt
cp ../gh-page/starcounter.data .
./starcounter.py -s -v -t day  >>../README.md
cp starcounter.data ../gh-page/
popd

#pushd gh-page
#
#git config --global user.email "a@gmail.com"
#git config --global user.name "MoserMichael"
#
#echo "*** pushing changed file ***"
#
#git add README.md
#git add .starcounter.data
#
#git commit -m "automatic build $(date)"
#expect -f /ex
#
## generate some action in the main repository, so that the CI job will not get disabled.
#git checkout master
#date >> ci-runs.txt
#git add ci-runs.txt
#git commit -m "automatic build $(date)"
#expect -f /ex
#popd
#
