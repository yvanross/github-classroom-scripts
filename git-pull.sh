if [ -z $1 ] || [ -z $2 ]; then
  echo "third parameter is the find maxdepth for directory"
  echo './git-pull.sh "/Users/rossypro/Downloads" 3'
  echo './git-pull.sh "/Users/rossypro/Downloads/LOG210-LAB0"  2' 
  echo './git-pull.sh "/Users/rossypro/Downloads/LOG210-LAB01/yvan"  1'
else 
  clear
  counter=0
  for group in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$group"
    echo "------------------------------------------------------------------- "
    echo "$counter => $group"
      git pull origin master --no-edit
  done
fi