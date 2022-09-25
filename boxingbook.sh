#!/bin/bash
# As of 21-01-2021 this script is working
# Created by Dylan Jenkins, to be used for educational purposes only
# In future this script will check to see if the class is available and if so book

# Read day to book
echo "Enter date for booking e.g. 2021-01-15"
read target

# Fetch timetable
echo "curling time table for $target"
timetable=$(curl 'https://ufcgymjbr.gymtour.app/ufc-hmvc/mobile/v1/class-session?date='+$target+'&user_id=4945')

# Determine session ID of class
session_id=`grep -o '.*BOXING' <<< $timetable | tail -c 21 | cut -c 1-5`
echo "Session ID for Boxing on $target is $session_id"

#TODO Check if class has free place
#TODO Check if able to book due to time limit

# snooze loop
# sleep until 00:01 Dubai time (15:00 EDT), doesn't account for daylight savings
echo "Starting sleep timer until 00:01"
while [ $(date +%H:%M) != "15:01" ]; do sleep 1; done

# book class
(curl 'https://ufcgymjbr.gymtour.app/ufc-hmvc/mobile/v1/subscribe?Class%5Buser_id%5D=1398&Class%5Bsession_id%5D='+$session_id'')
