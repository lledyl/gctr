#!/bin/bash

#Edit all cap words (YOURSERNAME,RCLONEMEGADROVE and RCLONEGOOGLEDRIVE)
#rename to mega.sh
#change permissions by using sudo chmod a+x mega.sh
#run by using sh mega.sh
#add this to crontab using * * * * * sh mega.sh

#!/bin/bash

PIDFILE=/home/$USER/mlock.pid

if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create PID file"
    exit 1
  fi
fi
#echo "start mega move"
rclone move mega_drive: rclone_drive:mega --transfers 1 --drive-chunk-size 32M --bwlimit 225k --size-only  --ignore-existing --delete-empty-src-dirs --delete-after --transfers 1 -P
echo "finished clean up"
rm $PIDFILE
