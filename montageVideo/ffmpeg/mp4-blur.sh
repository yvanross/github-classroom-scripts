#!/bin/sh
clear
if [ $# -lt 6 ]; then   
echo "param1 - directory of files to blur"
echo "param2 - directory of blured files"
echo "param3 -  starting blur at x"
echo "param4 -  starting blur at y"
echo "param5 -  delta X"
echo "param6 -  deltaY"
echo "1152x720"
echo "./mp4-blur.sh '/Volumes/LaCie/Yvan/ets-cours/C01/seances' '/Volumes/LaCie/Yvan/ets-cours/C01/out' 975 0 175 615 "
exit 1
fi
seance_dir=$1
out_dir=$2
start_x=$3
start_y=$4
delta_x=$5
delta_y=$6

for f in $1/*; do
  echo "$f"
  filename=$(basename $f)
  out_filename="$out_dir/$filename"

  ffmpeg -hide_banner -loglevel panic -i "$f"  -filter_complex "[0:v]split=2[v0][v1]; [v0]crop=$delta_x:$delta_y:$start_x:$start_y,boxblur=10[fg]; [v1][fg]overlay=$start_x:$start_y[v]" -map "[v]" -map 0:a -c:v libx264 -c:a copy -movflags +faststart  "$out_filename"
done