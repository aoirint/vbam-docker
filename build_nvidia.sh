#!/bin/bash

# for nvidia-driver machine
BASE_IMAGE=nvidia/opengl:base-ubuntu18.04

echo "Building from NVIDIA base image."
docker build . -t aoirint/vbam --build-arg "BASE_IMAGE=${BASE_IMAGE}"
