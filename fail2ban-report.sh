#!/bin/bash

# Generate automatic reports about most problematic ip address
# so they can be specifically targeted

# Number of times each ip address has hit "maxattempts"

sudo echo "Number of times an IP address has hit 'max attempts'"
zgrep -h "Ban " /var/log/fail2ban.log* | awk '{print $NF}' | sort | uniq -c

sudo echo "...truncated by subnet mask"
zgrep -h "Ban " /var/log/fail2ban.log* | awk '{print $NF}' | awk -F\. '{print $1"."$2"."}' | sort | uniq -c  | sort -n | tail

sudo echo "IP Addresses Grouped by Fail2Ban section"
grep "Ban " /var/log/fail2ban.log | awk -F[\ \:] '{print $10,$8}' | sort | uniq -c | sort -n

sudo echo "Report on Day's Activity"
grep "Ban " /var/log/fail2ban.log | grep `date +%Y-%m-%d` | awk '{print $NF}' | sort | awk '{print $1,"("$1")"}' | logresolve | uniq -c | sort -n
