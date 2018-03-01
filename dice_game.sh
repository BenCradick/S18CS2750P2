#!/bin/sh

#array for holding the total of combination for each number
roll_likelyhood=()
#initialize the array for each number
for i in {1..6}; do
    for j in {1..6}; do
        combination=$(($i+$j))
        ((roll_likelyhood[$combination]++))
    done
done

#initialize score to 0
reward=0
#always true
while [ true ]; do
    #random number 1-6 simulates roll of dice
    dice1=$(( $RANDOM % 6 + 1 ))
    dice2=$(( $RANDOM % 6 + 1 ))
    #sum of the dice roll
    diceTotal=$(( $dice1 + $dice2 ))
    
    #if matching die score set to 0 and game exits
    if (( $dice1 == $dice2 )); then
        reward=0
        echo "Terminating game, final score $reward"
        exit
    #if die sum to 4 lose 50 points
    elif (( $diceTotal == 4)); then
        reward=$(($reward-50))
    #if die sum to 10 lose 100 points
    elif (( $diceTotal == 10 )); then
        reward=$(($reward-100))
    #otherwise points rewarded is 10 - combinations to get dice roll times 10
    else
        baseScore=$((10 - ${roll_likelyhood[$diceTotal]}))
        reward=$(($reward + $baseScore * 10))

    fi
    #ask if they want to quit, then quits if they want otherwise continues
    echo "would you like to continue playing? Press y for yes n for no. Current score is $reward"
    read answer
    if [ "$answer" == "y" ]; then
        :
    else
        echo "Final score was $reward"
        exit
       
    fi
done