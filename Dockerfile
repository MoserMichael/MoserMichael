
# no cowsay in alpine, so use ubuntu ...
FROM docker.io/ubuntu:latest

ARG GITHUB_TOKEN=""

# from https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
# some package installer requires tzinfo setup, tell it to install noninteractively.
RUN apt-get -qy update && DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends tzdata 

RUN apt-get install -qy bash python3 python3-venv python3-pip git expect cowsay fortune

WORKDIR /

COPY ./build.sh /



