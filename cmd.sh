  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] ; then
  echo './cmd.sh "/Users/rossypro/Downloads/LOG210-LAB0" 1 command'
  echo './cmd.sh "/Users/rossypro/Downloads/LOG210-LAB1" 2 command'
  echo  "git tag -a ACorriger -m 'A Corriger'"
else 
  clear
  counter=0
  for directory in $(find $1 -maxdepth $2 -type d); do
    cd "$directory"
    echo "------------------------------------------------------------------- "
    echo "$directory"
    eval "$3";
  done
fi