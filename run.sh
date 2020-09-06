#!/bin/bash
sudo docker run -it --rm --name vbam -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix vbam visualboyadvance-m
