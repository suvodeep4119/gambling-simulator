#!/bin/bash -x 

echo "Welcome to THE GAMBLING SIMULATOR"

#CONSTANTS
STAKE=100
BET=1
WIN=1
WINNING_STAKE_LIMIT=$((STAKE+(( (50*STAKE)/100 )) ))
LOSING_STAKE_LIMIT=$((STAKE-(( (50*STAKE)/100 )) ))
PLAY_PERIOD=20

#VARIABLES
dailyCash=$STAKE
dailyWonBetCounter=0
dailyLostBetCounter=0
totalDailyWonBetCounter=0
totalDailyLostBetCounter=0
daysWon=0
daysLost=0

#FUNCTIONS

#1
function placeBet() 
{
	winLoss=$((RANDOM%2))
	if [ $winLoss -eq $WIN ]
	then
		echo "Won Bet"
        ((dailyWonBetCounter++))
        ((totalDailyWonBetCounter++))
		((dailyCash++))
        echo "Balance :$dailyCash"
        echo ++++++++++
	else
		echo "Lost Bet"
        ((dailyLostBetCounter++))
        ((totalDailyLostBetCounter++))
		((dailyCash--))
        echo "Balance:$dailyCash"
        echo ++++++++++
	fi
}

#2
function dailyPlay()
{
    while (( $dailyCash > $LOSING_STAKE_LIMIT && $dailyCash < $WINNING_STAKE_LIMIT ))
    do
        placeBet
    done
    reachLimitMessage
    echo "+++++++++++++++++++++++++++++++"
    echo "Re-initializing dailyCash value,won & lost Amount"
    echo "*************************************************"
    dailyCash=$STAKE
    dailyWonBetCounter=0
    dailyLostBetCounter=0
}

#3
function reachLimitMessage()
{
    if (( $dailyCash == $LOSING_STAKE_LIMIT))
    then    
        echo "You reached Minimums"
        echo "Daily Cash remaining for the day: $dailyCash"
        echo "You LOST for the day"
        ((daysLost++))
        
    else    
        echo "You reached maximum"
        echo "Daily Cash remaining for the day: $dailyCash"
        echo "You Won for the day"
        ((daysWon++))
    fi

    echo "Amount Lost for the day: $dailyLostBetCounter"
    echo "Amount Won for the day: $dailyWonBetCounter"
}

#4
function periodicPlay()
{
    for (( day=1; day<=$PLAY_PERIOD; day++ ))
    do
        echo "Day $day"
        echo "********"
        dailyPlay
    done
    echo "After playing $PLAY_PERIOD days : "
    echo "Total Amount WON: $totalDailyWonBetCounter"
    echo "Total Amount LOST: $totalDailyLostBetCounter"
    echo "********************************************"
    if (( $totalDailyWonBetCounter>$totalDailyLostBetCounter ))
    then    
        echo " YOU WON !!"
        echo "Days Won: $daysWon"
        echo "XXXXXXXXXXXXXXXXXX"
    else
        echo "YOU LOST !!"
        echo "Days Lost: $daysLost"
        echo "XXXXXXXXXXXXXXXXXXXX"
    fi

    echo "Days Won: $daysWon by Amount: $ $totalDailyWonBetCounter & Days Lost: $daysLost by Amount: $ $totalDailyLostBetCounter"
    
}

#5
function play()
{
    periodicPlay
    
}




#MAIN
play

