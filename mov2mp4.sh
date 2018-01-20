#!/bin/bash

# this format is used to upload to youtube

ffmpeg -i input.mov -vcodec h264 -acodec aac output.mp4
