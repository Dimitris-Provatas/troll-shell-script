#!/bin/bash
# To run in a windows machine, run with the sh command

# clear the screen
clear

# https://stackoverflow.com/a/38340073
spin() {
    sp='/-\|'
    printf ' '
    while true; do
        printf '\b%.1s' "$sp"
        sp=${sp#?}${sp%???}
        sleep 0.05
    done
}

# https://stackoverflow.com/a/38340073
progressbar()
{
    bar="##################################################"
    barlength=${#bar}
    n=$(($1*barlength/100))
    printf "\r[%-${barlength}s ](%d%%) " "${bar:0:n}" "$1"
}

greetingmessage()
{
    # Get OS and print a more fitting message
    # https://stackoverflow.com/a/8597411
    # GNU Linux
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "$(id -un)@${HOSTNAME}:~\$ sudo rm -rf /"
        echo "password: "
        echo "Deleting Root Directory of host ${HOSTNAME}"
    # OSX
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "$(id -un)@${HOSTNAME} ~ % sudo formatMacAndTimemachine"
        echo "password: "
        echo "Deleting Root Directory of host ${HOSTNAME}"
    # WSL
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "$(id -un)@${HOSTNAME}:~\$ sudo rm -rf /"
        echo "password: "
        echo "Deleting Root Directory of host ${HOSTNAME}"
    # Windows Shell
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "PS C:\WINDOWS\system32> format"
        echo "Formatting ${HOSTNAME}"
    # Windows (not possible, but just in case)
    elif [[ "$OSTYPE" == "win32" ]]; then
        echo "PS C:\WINDOWS\system32> format"
        echo "Formatting ${HOSTNAME}"
    # FreeBSD
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        echo "$(id -un)@${HOSTNAME}:~\$ sudo rm -rf /"
        echo "password: "
        echo "Deleting Root Directory of host ${HOSTNAME}"
    # WTF?
    else
        printf "Unknown Operating System.\n"
        exit 1
    fi
}

# infinite loop, we are just messing around
while true; do
    # break with the second keyboard interrupt input
    trap break SIGINT
    
    greetingmessage()
    
    sleep 1

    # init spinner, get its pid
    spin &
    pid=$!

    # https://stackoverflow.com/a/38340073
    for i in `seq 1 100`;
    do
        # break with the first keyboard interrupt input
        trap break SIGINT

        progressbar $i
        sleep $[ ( $RANDOM % 10 ) + 1 ]
    done

    # if the first keyboard interrupt is invoked
    printf "\nYou cannot stop this action! Restarting in 5 seconds!"

    # kill spinner
    kill $pid > /dev/null 2>&1

    sleep 5

    clear
done

# Well played and exit with code 0
printf "\nBravo! You got the fact that it is 2 loops you have to close the program!\n"
exit 0

