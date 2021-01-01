  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z $1 ] || [ -z $2 ]; then
  echo './git-push.sh "/Users/rossypro/Downloads/LOG210-LAB0" "message"' 
  echo './git-push.sh "/Users/rossypro/Downloads/LOG210-LAB1" "message"'
else 
  counter=0
  for root in "$1/*"; do
    for group in $root/*; do
      counter=$(( $counter + 1 ))
      cd "$group"
      echo "------------------------------------------------------------------- "
      echo "$counter => $group"
      git status
      git add .
      git commit -am "$2"
      git push --set-upstream origin master
    done  
  done
fi