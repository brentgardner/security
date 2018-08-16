#/bin/bash

#port scanning script

mkdir /opt/nmap_diff

hosts="/opt/scripts/hosts.txt"
tdate=$(date +%Y-%m-%d)
ydate=$(date -d yesterday +%Y-%m-%d)

while IFS= read -r host
do
    /usr/bin/nmap -T4 -oX /opt/nmap_diff/scan_$tdate_$host.xml $host > /dev/null 2>&1

    if [ -e /opt/nmap_diff/scan_$ydate_$host.xml ]; then
        /usr/bin/ndiff /opt/nmap_diff/scan_$ydate_$host.xml /opt/nmap_diff/scan_$tdate_$host.xml > /opt/nmap_diff/diff.txt
    fi

    echo "$host"
done < "$hosts"