#!/bin/bash

# this may need some adjusts on parameters,
# but that's the common way to convert it

#ffmpeg -i animated.gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" video.mp4

ffmpeg -i animated.gif -movflags faststart -pix_fmt yuv420p video.mp4
