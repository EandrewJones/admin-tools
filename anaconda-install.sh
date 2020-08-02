#!/bin/bash

# This script installs anaconda on the server and creates a group
# for access across multiple users

# install dependencies
sudo apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

# get install shell script from repo
curl -O https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh

# verify integrity of installer
sha256sum Anaconda3-2020.02-Linux-x86_64.sh

# run the anaconda script
sudo bash Anaconda3-2020.02-Linux-x86_64.sh

# remove anaconda script
sudo rm Anaconda3-2020.02-Linux-x86_64.sh


