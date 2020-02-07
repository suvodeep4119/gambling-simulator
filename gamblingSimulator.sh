#!/bin/bash -x

echo "Welcome to THE GAMBLING SIMULATOR"

#CONSTANTS
STAKE=6
BET=1
WIN=1
WINNING_STAKE_LIMIT=$((STAKE+(( (50*6)/100 )) ))
LOSING_STAKE_LIMIT=$((STAKE-(( (50*6)/100 )) ))
PLAY_PERIOD=3

#DICTIONARY
declare -A dailyWon
declare -A dailyLoss

#VARIABLES
dailyCash=$STAKE
dailyWonAmount=0
wonAmountTotal=0
dailyLostAmount=0
lostAmountTotal=0
daysWonCounter=0
daysLostCounter=0
#FUNCTIONS

#Function for EACH BET taking place
function placeBet()
{
	winLoss=$((RANDOM%2))
	if [ $winLoss -eq $WIN ]
	then
		((dailyCash++))
		echo $dailyCash
		((dailyWonAmount++))
		echo $dailyWonAmount
	else
		((dailyCash--))
		echo $dailyCash
		((dailyLostAmount++))
		echo "$dailyLostAmount"
	fi
}

function totalAmountWonLoss()
{
	if [ $wonAmountTotal -gt $lostAmountTotal ]
	then
		echo "You Won !! "
		(($wonAmountTotal))
		echo "Total days won: " $(($daysWonCounter))
		echo "Amount won per day:"  ${!dailyWon[@]}
	else
		echo "You Lost !! "
		(($lostAmountTotal))
		echo "Total days lost: " $(($daysLostCounter))
		echo "Amount lost per day: " ${!dailyLoss[@]}
	fi
}

function dailyWonLoss()
{
	
	if [ $dailyWonAmount -gt $dailyLostAmount ]
	then
		echo "You won for the day"
		((daysWonCounter++))
		#dailyWon[$day]=$dailyWonAmount
	else
		echo "You lost for the day"
		((daysLostCounter++))
		#dailyLoss[$day]=$dailyLostAmount
	fi
}

#MAIN
#Loop for 20 days
for (( day=1; day<=$PLAY_PERIOD; day++ ))
do
	#Loop for 1-day/per-day
	while (( $dailyCash > $LOSING_STAKE_LIMIT && $dailyCash < $WINNING_STAKE_LIMIT ))
	do
		placeBet
	done
	#Reflect dailyCash & daily Won/Loss Amount at day's end and post message
	echo "Daily Cash" $dailyCash
	(($dailyWonAmount))
	(($dailyLostAmount))
	dailyWonLoss
	wonAmountTotal=$(( $wonAmountTotal+$dailyWonAmount ))
	dailyWon[$daysWonCounter]=$dailyWonAmount
	lostAmountTotal=$(( $lostAmountTotal+$dailyLostAmount ))
	dailyLoss[$daysLostCounter]=$dailyLostAmount
	dailyCash=$STAKE
done
totalAmountWonLoss


