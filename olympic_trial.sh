#!/bin/sh
#declaring array for later use

laps=()
echo "Please enter your name"
#reads name and any time inputs you may have given
read name laps[0]  laps[1] laps[2]  laps[3]  laps[4]
#checks to see if your name is blank
while [ -z "$name" ]; do
    echo "Name left blank please enter name"
    read name
done
#checks to see if you only entered your name
if [ -z "${laps[0]}" ]; then
    echo "Please enter your time trials"

    read laps[0]  laps[1] laps[2]  laps[3]  laps[4]   
fi
#makes sure all time trials are entered
for i in {0..4}; do
    while [ -z "${laps[i]}" ]; do
        echo "please enter time number $i"
        read laps[$i]
    done
done

#sums time trials using Basic Calculor bash can't handle floats
sum=$(echo ${laps[0]}+${laps[1]}+${laps[2]}+${laps[3]}+${laps[4]} | bc)

#multiplies everything by 10 because only 1 decimal precision was specified
avg=$(echo "$sum * 10" | bc )
#averages everything rounds the 100th place and down
avg=$(echo "$avg / 5" | bc)

#checks to see if runner made the cut
if (( $avg <= 115 )); then
    echo "$name, Welcome to the team!"

elif (( $avg > 115 )); then
    echo "Close, but you did not make the cut"
#improper input will print out an error
else
    echo "ERROR: incorrectly formatted data"
fi