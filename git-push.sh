  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
  echo "third parameter is the find maxdepth for directory"
  echo './git-push.sh "/Users/rossypro/Downloads/LOG210-LAB0" "message" 2' 
  echo './git-push.sh "/Users/rossypro/Downloads/LOG210-LAB1" "message" 1'
else 
  clear
  counter=0
  for group in $(find $1 -maxdepth $3 -type d); do
    counter=$(( $counter + 1 ))
    cd "$group"
    echo "------------------------------------------------------------------- "
    echo "$counter => $group"
    git pull
    git add .
    git commit -am "$2"
    git push --set-upstream origin master
  done
fi