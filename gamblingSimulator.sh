#!/bin/bash -x 

echo "Welcome to THE GAMBLING SIMULATOR"

#CONSTANTS
STAKE=100
BET=1
WIN=1
WINNING_STAKE_LIMIT=$((STAKE+(( (50*100)/100 )) ))
LOSING_STAKE_LIMIT=$((STAKE-(( (50*100)/100 )) ))

#VARIABLES
dailyCash=$STAKE

#FUNCTIONS
function placeBet()
{
	winLoss=$((RANDOM%2))
	if [ $winLoss -eq $WIN ]
	then
		echo "Win"
		((dailyCash++))
	else
		echo "Loss"
		((dailyCash--))
	fi
}

#MAIN
while (( $dailyCash > $LOSING_STAKE_LIMIT && $dailyCash < WINNING_STAKE_LIMIT ))
do
	placeBet
done

#Reflect dailyCash at day's end and post message
(($dailyCash)) 
echo "You're done for the day"
