#!/bin/sh
# A POSIX variable
  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z "$1" ]; then
  echo './git-enable.sh  "/Users/rossypro/Downloads/S20203-lab1-rapport"'
  exit 0
fi
clear
for root in "$1/*"; do
  for group in $root/*; do
    cd "$group"
    echo "$group"
    origin=$(git remote get-url --push origin)
    case "$origin" in *token*)
      new_origin=$(git remote get-url --push origin | cut -c 65-1000)
      new_origin=$(echo "git@github.com:$new_origin")
      git remote remove origin
      git remote add origin $new_origin
      ;;
    esac
  done  
done


