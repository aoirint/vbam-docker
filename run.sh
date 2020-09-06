#!/bin/bash
sudo docker run -it --rm --name vbam \
  -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device /dev/snd \
  -v $PWD/vbam:/vbam \
  vbam \
  visualboyadvance-m
