#!/bin/bash
storage_dir=/media/hdd
while true; do
  destdate=$(date "+%Y_%m_%d")
  desttime=$(date "+%H_%M_%S")
  storage_percent_used=$(df -h | grep $storage_dir | awk '{print $5}' | sed 's/.$//')
  if [ "$storage_percent_used" -ge "90" ]; then
    dirtodelete=$(ls $storage_dir/????_??_?? -X -d -1| head -1 )
    rm -R $dirtodelete
  fi
  if ! [ -d $storage_dir/$destdate ]; then
    mkdir $storage_dir/$destdate
  fi
  ffmpeg -t 00:01:00 -i rtsp://login:password@192.168.1.3/ -vcodec copy -an "$storage_dir/$destdate/$desttime.mp4" 2> /dev/null
done
