#!/bin/bash

set -ex

cd / 

export PATH=/usr/games:$PATH

# checkout user repository
git clone $USER_REPO repo

# path to readme
README_FILE=/repo/README.md
echo "path to readme file: $README_FILE"

# initial part of radme
pushd repo
cat start_part.txt >${README_FILE}
popd

# get cowsay
git clone https://github.com/MoserMichael/opinionated-fortune-cow  cows

export PATH=/usr/games/:$PATH

pushd cows

# con't want to see first time init part...
./cows.sh >/dev/null

./cows.sh >>${README_FILE}

popd

pushd repo
cat common_part.txt >>${README_FILE}
popd

if [[ -z $GITHUB_TOKEN ]]; then
    echo "token does not exist, can't upload and can't count stars"
    exit 1
fi

git clone https://github.com/MoserMichael/githubapitools 

pushd githubapitools
ls -al
pip3 install -r requirements.txt
if [[ -f ../repo/starcounter.data ]]; then
    cp ../repo/starcounter.data .
fi
./starcounter.py -l -s -v -t day  >>${README_FILE}
cp starcounter.data ../repo/
popd

pushd repo
cat end_part.txt >>${README_FILE}
popd


pushd repo

git config --global user.email "a@gmail.com"
git config --global user.name ${GITHUB_USER}

echo "*** pushing changed file ***"

git add README.md
git add starcounter.data

git commit -m "automatic build $(date)"
expect -f ./ex

