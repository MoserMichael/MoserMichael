#!/bin/bash

set -ex

cd / 

export PATH=/usr/games:$PATH

# checkout user repository
git clone $USER_REPO repo

# path to readme
README_FILE=$PWD/repo/README.md

# initial part of radme
pushd repo
cat start_part.txt >${README_FILE}
popd

# get cowsay
git clone https://github.com/MoserMichael/opinionated-fortune-cow  cows

export PATH=/usr/games/:$PATH

pushd cows
./cows.sh >>${REAMDE_FILE}
popd

cat common_part.txt >>${README_FILE}

if [[ -z $GITHUB_TOKEN ]]; then
    echo "token does not exist, can't upload and can't count stars"
    exit 1
fi

git clone https://github.com/MoserMichael/githubapitools 

pushd githubapitools
ls -al
pip3 install -r requirements.txt
cp ..//starcounter.data .
./starcounter.py -s -v -t day  >>${README_FILE}
cp starcounter.data ../repo/
popd

pushd repo

git config --global user.email "a@gmail.com"
git config --global user.name ${GITHUB_USER}

echo "*** pushing changed file ***"

git add README.md
git add starcounter.data

git commit -m "automatic build $(date)"
expect -f ./ex

