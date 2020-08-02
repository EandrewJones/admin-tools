#!/bin/bash

# This utility installs Rstudio-server for Ubuntu 18.04

# Check dependencies
sudo apt-get install gdebi-core

# Download installer .deb files
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1056-amd64.deb

# install
sudo gdebi rstudio-server-1.3.1056-amd64.deb

# Open ufw firewall to allow traffic on port 8787 (default
sudo touch /etc/ufw/applications.d/rstudio-server
sudo su -
cat <<EOT>> /etc/ufw/applications.d/rstudio-server
[rstudio-server]
title=Rstudio Server
description=Rstudio server provides a browser based interface to a version of R running on a Linux server.
ports=8787
EOT
exit
sudo ufw allow rstudio-server

# check Rstudio-server version
sudo rstudio-server verify-installation

# Add forwarding from port 80 to 8787 so that
# the server can be hosted via a http dns
sudo iptables -A PREROUTING -t nat -i enp3s0 -p tcp --dport 80 -j REDIRECT --to-port 8787
