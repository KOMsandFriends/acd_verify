#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "usage: ./acd_verify.sh LOCAL_FILE"
	exit
fi

FILE=$1
FILENAME=$(echo $FILE | rev | cut -d'/' -f1 | rev)
#TMP="/tmp/verifyACD-"$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)
LOG="/var/log/acd_verify.log"

echo $(date) >> $LOG
echo "local file:" >> $LOG
echo $FILE >> $LOG

echo "REMOTE: Looking for filename "$FILENAME"..."
RESULT=''
RESULT=$(acd_cli find $FILENAME)
if [ "$RESULT" ]; then
	echo "FILENAME CHECK: [OK]" >> $LOG
	echo "REMOTE: filename found."
	echo "matching file(s): "$RESULT >> $LOG
else
	echo "FILENAME CHECK: [FAILED]" >> $LOG
	echo "REMOTE: filename not found. Leaving."
	echo "---" >> $LOG
	exit
fi

echo "LOCAL: Calculating MD5 sum of "$FILENAME". Might take a while..."
SUM=$(md5sum $FILE | cut -f1 -d' ')

echo "REMOTE: searching for MD5 "$SUM"..."
RESULT=''
RESULT=$(acd_cli find-md5 $SUM)
if [ "$RESULT" ]; then
    echo "MD5 CHECK: [OK]" >> $LOG
    echo "REMOTE: md5 sum found."
	echo "matching file(s): "$RESULT >> $LOG
else
    echo "MD5 CHECK: [FAILED]" >> $LOG
    echo "REMOTE: md5 sum not found. Leaving."
	echo "---" >> $LOG
    exit
fi

echo "---" >> $LOG

echo "Looks good. Results written to: "$LOG
