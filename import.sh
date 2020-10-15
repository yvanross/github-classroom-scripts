#!/bin/sh
# A POSIX variable
OPTIND=1 
while getopts “s:f:d:h:” opt; do
  case $opt in
    s) source="$OPTARG" ;;
    f) search="$OPTARG";;
    d) destination="$OPTARG" ;;
  esac
done
if [ -z "$source" ] || [ -z "$search" ] || [ -z "$destination" ]; then
  echo "./import.sh -s \"/Users/rossypro/Downloads/S20203-lab1-rapport\" -f \"*rapport*\" -d \"/Users/rossypro/Downloads/LOG210-LAB1\""  
  exit 0
fi
clear
for root in "$source/*"; do
  for group in $root/*; do
    cd "$group"
    group_name=$(basename "$group")
    path=$(dirname "$group")
    directory=$(basename $path)
    destination_path="$destination/$directory/$group_name"

    for file in $(find . -type f -name "$search") 
    do
      echo "---- "
       cp -fv "$group/$file"   "$destination_path/$file"
    done

  done  
done