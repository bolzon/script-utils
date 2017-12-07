#!/bin/bash

# compress mp4 videos

ffmpeg -i input.mp4 -vf scale=iw/2:-1 output.mp4
