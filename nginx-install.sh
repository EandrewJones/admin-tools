#!/bibn/bash

# This utility installs nginx for ubuntu 18.04

# Add nginx repo to apt
sudo echo "deb https://nginx.org/packages/mainline/ubuntu/ bionic nginx" >> /etc/apt/sources.list
sudo echo "deb-src https://nginx.org/packages/mainline/ubuntu/ bionic nginx" >> /etc/apt/sources.list

# Checking signing key
sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

# Install nginx
sudo apt update
sudo apt-get install nginx

# Turn on nginx and enable nginx on boot
sudo systemctl start nginx
sudo systemctl enable nginx

# Verify install
sudo nginx
curl -I 127.0.0.1

# Disable the default Welcome to NGINX page
sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled



