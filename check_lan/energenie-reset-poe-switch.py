from energenie import switch_on, switch_off
from time import sleep

# turn plug socket 2 on then off then on twice just in case  = the POE switch
print 'POE switch reset script - Will power off and on the POE LAN switch'
print 'Turn on socket 2'
switch_on(2)
print 'Sleep for 5 seconds'
sleep(5)
print 'Turn OFF socket 2'
switch_off(2)
print 'Sleep for 5 seconds'
sleep(5)
print 'Turn on socket 2'
switch_on(2)
print 'Sleep for 5 seconds'
sleep(5)
print 'Turn on socket 2'
switch_on(2)
