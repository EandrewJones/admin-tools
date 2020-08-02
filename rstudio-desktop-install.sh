#!/bin/bash

#=========================#
# R and Rstudio Installer #
#=========================#
# This utility firs installs latest version of R from
# ubuntu 18.04 cran repo then installs Rstudio IDE

#
# INSTALL R
#

# Add R GPG key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# Add the R repo
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'

# Update package list
sudo apt update

# Install R
sudo apt install r-base

# Test R
R --version

#
# INSTALL RSTUDIO
#

# Install build dependencies
sudo apt install gdebi-core
sudo apt install dpkg-sig

# Obtain Rstudio gpg key
gpg --keyserver keys.gnupg.net --recv-keys 3F32EE77E331692F

# Download R studio
curl -O https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.3.1056-amd64.deb

# Validate build signature
sudo dpkg-sig --verify rstudio-1.3.1056-amd64.deb

# Install Rstudio
sudo gdebi rstudio-1.3.1056-amd64.deb

# verify install by checking version
rstudio version

# remove installer .deb file and .Rhistory
sudo rm rstudio-1.3.1056-amb64.deb .Rhistory
