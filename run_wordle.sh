#!/bin/bash

# 1. Build the image
docker build -t wordle-asm .

# 2. Allow Docker to access your screen
xhost +local:docker

# 3. Run the game
docker run --rm -it \
-v $(pwd):/app \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
wordle-asm