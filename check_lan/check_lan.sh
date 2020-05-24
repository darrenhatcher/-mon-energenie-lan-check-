#!/bin/sh

# --------------------------------------------------------------------------------
log_msg() {
	logger "check_lan.sh: $1"
	echo "check_lan.sh: $1" 
}
# --------------------------------------------------------------------------------
    # cron script for checking wlan connectivity
    # change 192.168.1.1 to whatever IP you want to check.
    #IP_FOR_TEST="192.168.1.1"
    IP_FOR_TEST="1.1.1.1"
    # 1.1.1.1 is cloudflare DNS server
    PING_COUNT=3
    DELAY=300 # 5 mins
    MAX_TRIES=12
    # total maximum, should be less than 59 minutes (delay * attmepts)

    PING="/bin/ping"
    IFUP="/sbin/ifup"
    IFDOWN="/sbin/ifdown --force"

    INTERFACE="eth0"

    # ping test
    $PING -c $PING_COUNT $IP_FOR_TEST > /dev/null 2> /dev/null

    if [ $? -ge 1 ]
    then
        log_msg "check_lan.sh: $INTERFACE seems to be unable to see $IP_FOR_TEST, trying to bring it up..."
	#for iLoop in {1..$MAX_TRIES}
	for iLoop in $(seq 1 $MAX_TRIES)
	do
		log_msg "Restarting the energenie plug (port 1) for attempt $iLoop of $MAX_TRIES"
		log_msg "Running:  /usr/bin/sudo /usr/bin/python /opt/check_lan/energenie-reset-router-p1.py"

		/usr/bin/sudo /usr/bin/python /opt/check_lan/energenie-reset-router-p1.py 
		log_msg "Restarted the energenie plug (port 1)."

		log_msg "Sleeping for $DELAY seconds for recheck $iLoop of $MAX_TRIES ..."
		sleep $DELAY

    		# ping test
    		$PING -c $PING_COUNT $IP_FOR_TEST > /dev/null 2> /dev/null
    		if [ $? -ge 1 ]
		then
       		 	log_msg "Attempt $iLoop for $INTERFACE still seems to be down, wait until next try..."
		else
       		 	log_msg "Restart worked ... $INTERFACE now able to see outside world"
			# exit the loop
			break
		fi
	done
	
    else
        log_msg "$INTERFACE is up to $IP_FOR_TEST"
    fi
