#!/bin/bash

PACKAGE=hiracchi/sphinx
TAG=latest
CONTAINER_NAME=sphinx

#USER_ID=$(shell id -u)
#GROUP_ID=$(shell id -g)
#-u $USER_ID:$GROUP_ID

docker run -it --rm --name ${CONTAINER_NAME} \
    --volume "${PWD}:/work" \
    "${PACKAGE}:${TAG}" \
    "$@"

