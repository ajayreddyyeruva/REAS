#!/bin/bash

CONTINUE_SNOOZE=1
function snooze() {
	if [ ${CONTINUE_SNOOZE} = 1 ]; then
		SNOOZE_LIMIT_MIN=$1
		zenity --question --text="Snooze for ${SNOOZE_LIMIT_MIN} minutes"

		SNOOZE=$?

		if [ ${SNOOZE} = 0 ]; then
			echo "User wants to snooze ${SNOOZE_LIMIT_MIN} minutes"
			sleep $((${SNOOZE_LIMIT_MIN} * 60))
		else
			echo "User doesn't wants to snooze"
			CONTINUE_SNOOZE=0
		fi
	else
		echo "User doesn't wants to continue with snooze"
	fi

}	
	

snooze 5
snooze 4
snooze 3
snooze 2
snooze 1

DISPLAY=:0 vlc --play-and-exit -f /home/user/Downloads/screen_lock.mp4

SCREEN_SAVER_START_TIME=`date +"%s"`
SCREEN_SAVER_END_TIME=$(($SCREEN_SAVER_START_TIME+60))

DISPLAY=:0 gnome-screensaver-command -l

SCREEN_SAVER_CURRENT_TIME=`date +"%s"`
while [ $SCREEN_SAVER_CURRENT_TIME -le $SCREEN_SAVER_END_TIME ]
do

	SCREEN_STATUS=`DISPLAY=:0 gnome-screensaver-command -q`
	echo "Screen status $SCREEN_STATUS"
	if [ "The screensaver is inactive" = "${SCREEN_STATUS}" ]
	then
		echo "As the screen lock time is not over locking it again"
		DISPLAY=:0 gnome-screensaver-command -l
	else
		echo "Screeen saver is active"
	fi
	SCREEN_SAVER_CURRENT_TIME=`date +"%s"`
	sleep 1
done

