#!/bin/bash

# This utility is for creating user accounts in bulk for class. 
# - Should only be used when users have same group priveleges and 
#   home directory to be installed in same location
# - Only allows one initial group
# - Args:
#	-u list of usernames
#	-p A tag that will be appended to username and set as default password
#	-d The directory under which user home directories will be stored
#	-g The default group to place these users in
# TODO allow for more groups per users

# get arguments
while getopts ":u:p:d:g:" opt; do
    case $opt in
	u)
	  echo "-u was triggered, Parameter: $OPTARG" >&2
	  USERNAMES=$OPTARG
	  ;;
	p)
	  echo "-p was triggered, Parameter: $OPTARG" >&2
	  TAG=$OPTARG
	  ;;
	d)
	  echo "-d was triggered, Parameter: $OPTARG" >&2
	  DIR=$OPTARG
	  ;;
	g)
	  echo "-g was triggered, Parameter: $OPTARG" >&2
	  GROUP=$OPTARG
	  ;;
	\?)
	  echo "Invalid option: -$OPTARG" >&2
	  exit 1
	  ;;
	:)
	  echo "Option -$OPTARG requires an argument." >&2
	  exit 1
	  ;;
    esac
done

# Create users and passwords
for user in $USERNAMES; do
    sudo useradd -s /bin/bash -d ${DIR}/$user -m -G $GROUP $user
    echo "${user}:${user}_${TAG}" | sudo chpasswd
    echo "$user created."
done

