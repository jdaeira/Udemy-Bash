#!/bin/bash

# Count the number of failed logins by IP address.
# If there are any IPs with over LIMIT failures, display the count, IP, and location.

LIMIT='10'
LOG="${1}"

# Make sure a file was supplied as an argument.
if [ -f "$LOG" ]
then
    # Display the CSV header.
    echo "Count,IP,Location"
else
    echo "No File was provided"
    exit 1
fi


# Loop through the list of failed attempts and corresponding IP addresses.
cat syslog-sample | grep -i 'failed' | awk -F ' ' '{print $(NF - 3)}' | sort | uniq -c | sort -nr | 
while read COUNT IP
do
    # If the number of failed attempts is greater than the limit, display count, IP, and location.
    if [[ "${COUNT}" -gt "${LIMIT}" ]]
    then
        LOCATION=$(geoiplookup ${IP} | awk -F ', ' '{print $2}')
        echo "${COUNT},${IP},${LOCATION}"
    fi

done
