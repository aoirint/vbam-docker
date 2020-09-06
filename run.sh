#!/bin/bash
sudo docker run -it --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix vbam /work/build/visualboyadvance-m
