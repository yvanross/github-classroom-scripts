  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z $1 ]; then
  echo './git-statis.sh "/Users/rossypro/Downloads/LOG210-LAB0" maxdepth' 
  echo './git-status.sh "/Users/rossypro/Downloads/LOG210-LAB1" 2'
else 
  counter=0
  for dir in $(find $1 -maxdepth $2 -type d); do
      counter=$(( $counter + 1 ))
      cd "$dir"
      echo "---------------------------------------------------------------"
      echo "$counter => $dir"
      git status
 
  done
fi