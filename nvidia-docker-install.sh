#!/bin/bash

# This file installs the nvidia docker repository.

# check for legacy nvidia-docker containers and remove
sudo docker volume rm -f $(docker volume ls -q -f driver=nvidia-docker)
sudo docker system prune -a
sudo apt-get purge nvidia-docker 

# configure the nvidia-docker repo
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# isntall nvidia-docker v2
sudo apt-get update && sudo apt-get install nvidia-container-toolkit
sudo systemctl restart docker

# test install
sudo docker run --gpus all --rm nvidia/cuda:10.0-base nvidia-smi

# Remove and kill all docker images/containers on system
sudo docker prune -a
