#!/bin/bash

# converts all jpg's of directory into a gif (https://imagemagick.org)

convert -delay 20 -loop 0 *.jpg myimage.gif
