# mon-energenie-lan-check
This is a small project to monitor an IP and restart a router using Energenie devices

## Requirements
It requires the Energenie Python library and a Raspberry Pi that can be found here:
https://pypi.org/project/energenie/

Use ```pip install energenie``` to install (this is v1.0.1 as of time of writing).

## Test Version
Tested on Python 2.7.3 - yes this is old but it works.

# Usage
* Setup the Energenie plugs so you can turn on and off with a known numeric ID and make a note of them. Do not try to do this with code until you can do the same with a handheld device (this helps with debugging later). ID numbers start from ```1``` - don't try zero.
* Install the python library as above.
* Install the ```check_lan``` folder in ```/opt```.
* Add a crontab entry so can run as ```root``` - note this is needed to access the Energenie hardware.
* Test using the ```energenie-test.py``` script - edit the ID into the script and verify you can turn on/off using that script.

If doing this manually, add an entry using ```sudo``` to add an entry like this to check every hours, 29 minutes past the hour:
```
# this first command is the test to see if the link is down and togglethe power to the router if on
29 * * * *   /usr/bin/logger "Planned DSL/LAN check 29 past hour ..."; /opt/check_lan/check_lan.sh >  /tmp/router-lan-check-log.txt
```
What this will do is put a message in ```/var/log/messages``` at each check. The check script will also put text into the same log file so you can verify what it is doing. Ensure the ID of the plug you are using matches that run from the ```check_lan.sh``` shell script which is in ```energenie-reset-router-p1.py```. In this example, it is port ```1```.
