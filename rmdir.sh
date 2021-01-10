
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ]; then
  echo "third parameter is the find maxdepth for directory"
  echo './rmdir.sh "/Users/rossypro/Downloads/LOG210-LAB0" "dirname" depth execute' 
  echo './rmdir.sh "/Users/rossypro/Downloads/LOG210-LAB0" ".github" 2 false'

else 
  clear
  counter=0
  for group in $(find $1 -name $2 -maxdepth $3 -type d); do
    if [ "$4" == "true" ]; then
      echo "Remove $group"
      rm -rf $group
    else
      echo "$group"
    fi
  done
fi