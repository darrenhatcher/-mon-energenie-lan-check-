from energenie import switch_on, switch_off
from time import sleep

# this script is just to try to turn the power switch on three times in case someone leaves it off

# turn plug socket 1 on = router
switch_on(1)
sleep(5)
switch_on(1)
sleep(5)
switch_on(1)

# turn plug socket 2 on = the POE switch
switch_on(2)
sleep(5)
switch_on(2)
sleep(5)
switch_on(2)
