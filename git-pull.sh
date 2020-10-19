if [ -z $1 ]; then
  echo './git-pull.sh "/Users/rossypro/Downloads/LOG210-LAB0"'
  echo './git-pull.sh "/Users/rossypro/Downloads/LOG210-LAB1"'
else 
  # $1 is the path in /Users/rossypro/Downloads
  counter=0
  for root in "$1/*"; do
    for group in $root/*; do
   
      echo "$counter => $group"
      counter=$(( $counter + 1 ))
      cd $group
      echo "----------------------------------------------------- "
      git status
      git pull --no-edit
    done  
  done
fi