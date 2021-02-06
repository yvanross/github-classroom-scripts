if [ -z $1 ] || [ -z $2 ]; then
  echo "third parameter is the find maxdepth for directory"
  echo './git-reset "/Users/rossypro/Downloads" 3'
  echo './git-reset.sh "/Users/rossypro/Downloads/LOG121-strategie" 2'
  echo './git-reset.sh "/Users/rossypro/Downloads/LOG210-LAB0"  2' 
  echo './git-reset.sh "/Users/rossypro/Downloads/LOG210-LAB1/yvan"  1'
else 
  clear
  counter=0
  for group in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$group"
    echo "------------------------------------------------------------------- "
    echo "$counter => $group"
      git clean -fd
      git reset --hard HEAD
      git pull
  done
fi