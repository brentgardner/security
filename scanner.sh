#/bin/bash

#port scanning script
if [ "$1" != "" ]; then
    echo "hosts file found at $1"
else
    echo "host file is required and was not provided"
fi

if [ "$2" != "" ]; then
    echo "diff directory found at $2"
else
    echo "diff directory is required and was not provided"
fi

mkdir $2

diff_dir=$2
hosts=$1
tdate=$(date +%Y-%m-%d)
ydate=$(date -d yesterday +%Y-%m-%d)

while IFS= read -r host
do
    /usr/bin/nmap -Pn -sV --script=banner -oX $diff_dir/scan_$tdate_$host.xml $host > /dev/null 2>&1

    if [ -e $diff_dir/scan_$ydate_$host.xml ]; then
        /usr/bin/ndiff $diff_dir/scan_$ydate_$host.xml $diff_dir/scan_$tdate_$host.xml > $diff_dir/diff_$host.txt
    fi

    echo "$host"
done < "$hosts"