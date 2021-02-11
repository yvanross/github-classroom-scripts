#!/bin/sh
# A POSIX variable
  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z "$1" ]; then
  echo './git-enable.sh  "/Users/rossypro/Downloads/S20203-lab1-rapport"'
  exit 0
fi
clear
for group in $(find $1 -maxdepth $2 -type d); do
     cd "$group"
     
    echo "$group"
    origin=$(git remote get-url --push origin)
    if [[ $origin == *"@github.com:cc-yvan"* ]]; then
      echo "already modified"
    else
      new_origin="${origin#*/}"
      new_origin=$(echo "git@github.com:$new_origin")
      git remote remove origin
      git remote add origin $new_origin
    fi
done


