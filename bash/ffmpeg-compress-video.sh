#!/bin/bash

# compress mp4 videos

ffmpeg -i input.mp4 -vf scale=iw/2:-1 output.mp4

# compress mp4 video (divide 1GB by the video length in seconds - this is the 'b' parameter)

ffmpeg -i input.mp4 -b 1000000 output.mp4
