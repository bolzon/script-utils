#!/bin/bash

# this software uses SOX lib
# to install it, run command below:

#sudo apt-get install sox libsox-fmt-all

# converts mp3 files to gsm (gsm files will be in gsm folder)
for f in *.mp3; do F=$(echo $f | sed "s/\.mp3//"); sox $f -r 8000 -c 1 gsm/$F.gsm; done;
