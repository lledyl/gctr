#!/bin/bash
tput setaf 2; echo "Checking duplicate process"
PIDFILE=~/.lock.pid
if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    tput setaf 1; echo "Process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      tput setaf 1; echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    tput setaf 1; echo "Could not create PID file"
    exit 1
  fi
fi

tput setaf 2; echo "No duplicate process found"
tput setaf 2; echo "Change permissions"
tput setaf 7;
sudo chown -R $USER:$USER /complete/*
tput setaf 2; echo "Delete torrent waste files"
tput setaf 7;
find /complete/ \( -name '*sample.mp4' -o -name '*.srt' -o -name '*.nfo' -o -name '*.jpeg' -o -name '*.jpg'  -o -name '*.txt' -o -name '*.url' -o -name '*.png' -o -name '*.gif' -o -name '*.htm*' -o -name '*.exe' -o -name '*.zip' \) -type f -delete
tput setaf 2;  echo "Moving files"
tput setaf 7;
mv /complete/*/*.mp4 /complete/video_files_only
mv /complete/*/*.mkv /complete/video_files_only
mv /complete/*/*.wma /complete/video_files_only
mv /complete/video_files_only/*-A.mp4 /complete
mv /complete/video_files_only/*-B.mp4 /complete
mv /complete/video_files_only/*-C.mp4 /complete
mv /complete/video_files_only/*-D.mp4 /complete
mv /complete/video_files_only/*-E.mp4 /complete
tput setaf 2; echo "Delete empty folders"
tput setaf 7;
find /complete/*  -type d -empty -delete
tput setaf 2; echo "Moving files to Google drive"
tput setaf 7;
rclone move   /complete rclone_drive:folder  --min-age 61s --include-from filter.txt --size-only --delete-empty-src-dirs --ignore-existing -P --log-file=mylogfile.txt --drive-stop-on-upload-limit
tput setaf 2; echo "Cleaning transmission"
tput setaf 7;
sh .clean_transmission.sh
tput setaf 2; echo "Delete lock file"
rm $PIDFILE
echo "Done"