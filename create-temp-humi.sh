#!/bin/bash
# This script by Joerg Neikes gets the temp and humidity value from a DTH22.
# The Values are writeen all 15 minutes to a log file.
# Like all of my scripts this uses GPL Version 3
# You find it here http://www.gnu.org/licenses/gpl-3.0.en.html

# Where your loldht is
PROG="/sbin/loldht"
# Used PIN
PIN="7"
# Both values 
THLOG="/var/ramfs/temp-humi.log"
# Write only temperature to this folder
TLOG="/var/ramfs/temp.log"
# Write only humidity  to this folder
HLOG="/var/ramfs/humi.log"

# Both data values in one file
GTDTA=$( ${PROG} ${PIN} | grep Humidity | awk '{ print $7 " " $3}' > ${THLOG} )


TEMP=$(cat ${THLOG} | awk '{ print $1 }' )
HUMI=$(cat ${THLOG} | awk '{ print $2 }' > ${HLOG} )

# Get all 15 Minutes new data
while true
do



# Get Temperature and add 0 for - and 1 for + used for only number database entrie
if [[ ${TEMP} == *"-"* ]]
then 
echo ${TEMP} | sed s/-/0/g > ${TLOG}
else
echo "1"${TEMP} > ${TLOG}; 
fi

# Get Humidity
${HUMI}

sleep 900

done 
