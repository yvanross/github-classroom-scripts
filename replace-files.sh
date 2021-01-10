// replace file
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ] || [ -z $5 ]; then
  echo "third parameter is the find maxdepth for directory"
  echo './replace-files.sh "/Users/rossypro/Downloads/LOG210-LAB0" README.md 2 "/Users/rossypro/sources/ets/log210/S20203-LOG210-Lab0/README.md" true'
  echo './replace_files.sh  "/Users/rossypro/Downloads/LOG210-LAB0" "filename" "fullfilepaht" replace' 
else 
  clear
  counter=0
  cd $1
  for filename in $(find $1 -name $2 -maxdepth $3 -type f); do
  if [ "$5" == "true" ]; then
    echo "cp $4 $filename"
    cp $4 $filename
  else
    echo "$filename"
  fi
   
  done
fi