#!/bin/bash -x 

echo "Welcome to THE GAMBLING SIMULATOR"

#CONSTANTS
STAKE=100
BET=1
WIN=1
#VARIABLES
dailyCash=$STAKE

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
placeBet
