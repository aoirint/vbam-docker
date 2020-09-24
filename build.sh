#!/bin/bash

nvidia-smi 1> /dev/null 2> /dev/null

if [ $? = 0 ]; then
  ./build_nvidia.sh
else
  ./build_ubuntu.sh
fi
