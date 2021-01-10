#!/bin/sh
# A POSIX variable
  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z "$2" ]; then
  echo './git-update-template.sh /Users/rossypro/Downloads/LOG121-lab01 git@github.com:yvanross/LOG121-LAB01.git '
  echo './git-update-template.sh /Users/rossypro/Downloads/LOG210-lab0 git@github.com:profcfuhrmanets/S20203-LOG210-Lab0.git '
  
  exit 0
fi
clear
for root in "$1/*"; do
  for group in $root/*; do
    cd "$group"
    echo "$group"
    git pull origin masger
    git remote add template "$2"
    git fetch --all
    git merge template/master --allow-unrelated-histories --no-edit
    rm -rf target
    # vi README.md
    git add .
    git commit -am "merge template"
    git push --set-upstream origin master
  done  
done