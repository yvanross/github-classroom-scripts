
if [ -z $1 ] || [ -z $2 ] ; then
  echo "third parameter is the find maxdepth for directory"
  echo './mvn-install.sh "/Users/rossypro/Downloads/LOG121-strategie/"  2' 
  echo './mvn-install.sh "/Users/rossypro/Downloads/LOG121-strategie/034059/yvan"  1'
else 
  clear
  counter=0
  for group in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$group"
    echo "------------------------------------------------------------------- "
    echo "$counter => $group"
    mvn install > correction-test.txt
    # mvn testj
  done
fi

