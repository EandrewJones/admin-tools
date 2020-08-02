#!/bin/bash

# This script follows the directions on digital ocean to install Docker-ce
# on Ubuntu 18.04 bionic beaver. Other versions can be installed by switching
# to the correct repo.
# Reference: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

# set variables
USER=evan

# update system
sudo apt update

# Add prequisite packages
DEPENDS="apt-transport-https ca-certificates curl software-properties-common"
sudo apt install -y $DEPENDS

# Add gpg key for official docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# update packages with docker packages from the newly added repo
sudo apt update

# Ensure install is from docker repo, not ubuntu default
apt-cache policy docker-ce

# install
sudo apt install docker-ce

# check that docker is running
sudo systemctl status docker

# add user to docker group and enforce immediately
sudo usermod -aG docker ${USER}
sudo su - ${USER}

# test install
sudo docker run --rm dbkdoc/whalefortune

