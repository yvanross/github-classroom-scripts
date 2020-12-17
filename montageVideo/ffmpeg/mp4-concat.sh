#!/bin/sh
clear
if [ $# -lt 3 ]; then   
echo "first param - directory of the fist file to concat"
echo "second param - directory of the second file to concat, name must match file from first directory"
echo "third param - output directory"
echo "./mp4-concat.sh '/Volumes/LaCie/Yvan/ets-cours/C01/intro' '/Volumes/LaCie/Yvan/ets-cours/C01/seances' '/Volumes/LaCie/Yvan/ets-cours/C01/out'"
exit 1
fi

seance_dir=$2
out_dir=$3
rm first.MTS
rm second.MTS
echo "file 'first.MTS'" > combine.txt
echo "file 'second.MTS'" >> combine.txt

for f in $1/*; do
  echo "$f"
  filename=$(basename $f)
  seance_filename="$seance_dir/$filename"
  out_filename="$out_dir/$filename"
  ffmpeg -hide_banner -loglevel panic -i "$f" -q 0 "first.MTS"
  ffmpeg -hide_banner -loglevel panic -i "$seance_filename" -q 0 "second.MTS"
  ffmpeg -hide_banner  -loglevel panic -f concat -safe 0 -i combine.txt  "$out_filename"
  rm first.MTS
  rm second.MTS
done
rm combine.txt