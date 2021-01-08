#!/bin/sh
clear
if [ $# -lt 3 ]; then   
echo "param1 - directory of files to unsilence"
echo "param2 - directory of silenced files"
echo "param3 -  silence db level"
echo "./mp4-unsilence.sh '/Volumes/LaCie/Yvan/ets-cours/C01/out' '/Volumes/LaCie/Yvan/ets-cours/C01/out_unsilence' 28.4 "
echo "./mp4-unsilence.sh /Users/rossypro/Documents/Zoom /Users/rossypro/Documents/Zoom/unsilence 28.4"
exit 1
fi
seance_dir=$1
out_dir=$2
silence_level=$3

for f in $1/*; do
  echo "$f"
  filename=$(basename $f)
  out_filename="$out_dir/$filename"
  python ./unsilence.py -t "-$silence_level" -i "$f" -o "$out_filename" 
  mv "$f" "$seance_dir/done/$filename"
done