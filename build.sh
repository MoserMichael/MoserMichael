#!/bin/bash
set -ex

cd / 

export PATH=/usr/games:$PATH

# checkout user repository
git clone $USER_REPO repo

# path to output files
README_FILE=/repo/README.md
TRAFFIC_REPORT_FILE=/repo/TRAFFIC_REPORT.md
STARRED_REPOS_FILE=/repo/USER_STARRED.md

# *** make README file ***

echo "[About this page](https://github.com/MoserMichael/MoserMichael/blob/master/ABOUT.md) generated at: " >${README_FILE}

date >>${README_FILE}
echo "" >>${README_FILE}

# init files
pushd repo
cat start_part.txt >>${README_FILE}
cat traffic_report.txt >${TRAFFIC_REPORT_FILE}
cat users_starred.txt >${STARRED_REPOS_FILE}
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

./starcounter.py -l -s -t day  >>${README_FILE}

cp starcounter.data ../repo/

./starcounter.py -l -t day -v  >>${TRAFFIC_REPORT_FILE}
./starcounter.py -l -r  >>${STARRED_REPOS_FILE}

popd

pushd repo
cat end_part.txt >>${README_FILE}
popd


pushd repo

git config --global user.email "a@gmail.com"
git config --global user.name ${GITHUB_USER}

echo "*** pushing changed file ***"

git add README.md
git add TRAFFIC_REPORT.md
git add USER_STARRED.md


git add starcounter.data

git commit -m "automatic build $(date)"
expect -f ./ex

