
#!/bin/sh
clear
if [ $# -lt 3 ]; then   
echo "param1 - directory of files to blur"
echo "param2 - directory of blured files"
echo "param3 -  volume en db"
echo "./mp4-volume.sh '/Volumes/LaCie/Yvan/ets-cours/C01/intro' '/Volumes/LaCie/Yvan/ets-cours/C01/out' 20 "
exit 1
fi
seance_dir=$1
out_dir=$2
volume=$3

for f in $1/*; do
  echo "$f"
  filename=$(basename $f)
  out_filename="$out_dir/$filename"

  ffmpeg -hide_banner -loglevel panic -i "$f" -filter:a "volume=$volume"  "$out_filename"
done
 