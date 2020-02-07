#!/bin/bash -x 

echo "Welcome to THE GAMBLING SIMULATOR"

#CONSTANTS
STAKE=100
BET=1
WIN=1
WINNING_STAKE_LIMIT=$((STAKE+(( (50*100)/100 )) ))
LOSING_STAKE_LIMIT=$((STAKE-(( (50*100)/100 )) ))
PLAY_PERIOD=20
#VARIABLES
dailyCash=$STAKE
dailyWonAmount=0
wonAmountTotal=0
dailyLostAmount=0
lostAmountTotal=0
#FUNCTIONS

#Function for EACH BET taking place
function placeBet()
{
	winLoss=$((RANDOM%2))
	if [ $winLoss -eq $WIN ]
	then
		echo "Win"
		((dailyCash++))
		((dailyWonAmount++))
	else
		echo "Loss"
		((dailyCash--))
		((dailyLostAmount++))
	fi
}

function totalAmountWonLoss()
{
	if [ $wonAmountTotal -gt $lostAmountTotal ]
	then
		echo "You Won !! "
		(($wonAmountTotal))
	else
		echo "You Lost !! "
		(($lostAmountTotal))
	fi
}
#MAIN
#Loop for 20 days
for (( day=1; day<=$PLAY_PERIOD; day++ ))
do
	#Loop for 1 day/per day
	while (( $dailyCash > $LOSING_STAKE_LIMIT && $dailyCash < WINNING_STAKE_LIMIT ))
	do
		placeBet
	done
	echo "You're done for the day"
	#Reflect dailyCash & daily Won/Loss Amount at day's end and post message
	(($dailyCash))
	(($dailyWonAmount))
	(($dailyLostAmount)) 
	wonAmountTotal=$(( $wonAmountTotal+$dailyWonAmount ))
	lostAmountTotal=$(( $lostAmountTotal+$dailyLostAmount ))
done
totalAmountWonLoss
