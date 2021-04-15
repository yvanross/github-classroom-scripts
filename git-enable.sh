#!/bin/sh
# enlève le token dans le git remote -v provenant de Github classroom.  Cela permet par la suite de faire des git push et pull sans problèmes.
# A POSIX variable
  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z "$1" ]; then
  echo './git-enable.sh  "/Users/rossypro/Downloads/S20203-lab1-rapport" 2'
  exit 0
fi
clear
for group in $(find $1 -maxdepth $2 -type d); do
    echo "---------------------------------------------------"
    cd "$group"
    echo "$group"
    origin=$(git remote get-url --push origin)
    if [[ -z "$origin" ]]; then
        continue
    fi 
    echo "origin => $origin"
    if [[ $origin == *"@github.com:cc-yvan"* ]]; then
      echo "already modified"
    else
      new_origin="${origin#*/}"
      new_origin=$(echo "git@github.com:$new_origin")
      echo "new_origin => $new_origin"
      echo "    "
      git remote remove origin
      git remote add origin $new_origin
      git remote -v

    fi
done


