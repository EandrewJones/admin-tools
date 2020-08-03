#!/bin/sh

# This utility creates a nginx configuration file
# specifying which port web traffic (port 80)
# should be redirected to for a given application

# Initialize null value vars to be specified by user
file_name=''
port=''

# Ask user for desired .conf file name and port
while  [ -z $file_name ]; do
    read -p 'Please specify a desired name for the nginx .conf file (E.g. nodeapp). Cannot be blank.:  ' file_name
done
while [ -z $port ]; do
    read -p 'Please specify the port this application is hosted on:  ' port
done

# Ask user to specify whether there is a domain name associated with this application/port
read -p 'Is there a domain name associated with this application/port (E.g. app.example.com)? If so, please specify it, else leave blank. ' web_address
if [ -z $web_address ]; then
   printf "WARNING: If there is no domain name associated with this service, then all web traffic on your server will be redirected from port 80 to this port.\n"
   printf "Do you wish to continue?"
   select yn in "Yes" "No"; do
	case $yn in
	    Yes ) continue;;
	    No ) read -p "Re-enter domain name:  " web_address;;
	esac
   done
fi

# Create config file according to server_nam
if [ -z $web_address ]; then
cat << EOF | sudo tee /etc/nginx/conf.d/${file_name}.conf
server {
    listen 80;
    listen [::]:80;

    location / {
	proxy_pass http://localhost:${port}/;
    }
}
EOF
else
cat << EOF | sudo tee /etc/nginx/conf.d/${file_name}.conf
server {
    listen 80;
    listen [::]:80;

    server_name ${web_address};

    location / {
	proxy_pass http://localhost:${port}/;
    }
}
EOF
fi

# Remind user that config files must be added as headers in main nginx.conf file to go into effect
printf "To add further options to the proxy, please edit the file located at /etc/nginx/conf.d/${file_name}.conf.\n"
