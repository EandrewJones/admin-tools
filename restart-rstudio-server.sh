#!/bin/bash

# This crontab utility checks whether rstudio-server is running, if not then re-hosts it.
if sudo netstat -lntup | grep rserver >/dev/null; then
	exit 0
else
	sudo rstudio-server start
fi

exit 0
