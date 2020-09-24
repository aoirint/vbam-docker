#!/bin/bash

# for general machine
BASE_IMAGE=ubuntu:bionic

echo "Building from Ubuntu base image."
docker build . -t aoirint/vbam --build-arg "BASE_IMAGE=${BASE_IMAGE}"
