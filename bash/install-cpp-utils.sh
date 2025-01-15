#!/bin/bash

# this script installs all dependency packages to start developing in C/C++

sudo apt-get install \
        build-essential \
        libtool \
        autotools-dev \
        automake \
        pkg-config \
        libssl-dev \
        libevent-dev \
        bsdmainutils
