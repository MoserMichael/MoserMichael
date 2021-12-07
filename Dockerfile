FROM alpine:3.12 

ARG GITHUB_TOKEN=""

RUN apk add bash python3 git expect

WORKDIR /

COPY ./build.sh /
COPY ./start_part.txt /
COPY ./common_part.txt /
COPY ./ex /

RUN GITHUB_TOKEN=${GITHUB_TOKEN} ./build.sh





