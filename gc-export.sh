#!/bin/sh
# export from github classroom directory to a destination directory
# Scan github classrom directories to extract file matching a search criteria and copy them on another directory with same structure.  This directory could be imported on table for manual correction of pdf or other.
# A POSIX variable
  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

OPTIND=1 
while getopts “s:f:d:h:” opt; do
  case $opt in
    s) source="$OPTARG" ;;
    f) search="$OPTARG";;
    d) destination="$OPTARG" ;;
  esac
done
if [ -z "$source" ] || [ -z "$search" ] || [ -z "$destination" ]; then
  echo "./gc-export.sh -s \"/Users/rossypro/Downloads/LOG210-LAB1\" -f \"*rapport*\" -d \"/Users/rossypro/Downloads/rapport\" " 
  exit 0
fi

for root in "$source/*"; do
  for group in $root/*; do
    cd "$group"
    group_name=$(basename "$group")
    path=$(dirname "$group")
    directory=$(basename $path)
    destination_path="$destination/$directory/$group_name"

    for file in $(find . -type f -name "$search") 
    do
      destination_filename="$destination_path/$file"
      parent=$(dirname "$destination_filename")
      echo " "
      echo "destination_filename=$destination_filename"
      echo "parent=$parent"
      echo "cp  $group/$file =>  $destination_path/$file"
      mkdir -pv "$parent"
      cp "$group/$file"   "$destination_path/$file"
    done

  done  
done