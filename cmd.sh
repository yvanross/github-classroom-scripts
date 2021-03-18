  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] ; then
  echo './cmd.sh "/Users/rossypro/Downloads/LOG210-LAB0" 1 command'
  echo './cmd.sh "/Users/rossypro/Downloads/LOG210-LAB1" 2 command'
  echo  "git tag -a ACorriger -m 'A Corriger'"
  ' ./cmd.sh "/Users/rossypro/Downloads/LOG210-lab01" 2 "tplant --input 'src/**/**/*.ts' --output correction.svg" 2
  ' ./cmd.sh "/Users/rossypro/Downloads/LOG210-lab01" 2 "gh issue list > correction-issues.txt" 2
else 
  clear
  counter=0
  for directory in $(find $1 -maxdepth $2 -type d); do
    cd "$directory"
    echo "------------------------------------------------------------------- "
    if [ !  -f "README.md" ] ; then
        continue;
    fi
    echo "$directory"
    eval "$3";
  done
fi

# /Users/rossypro/Downloads/LOG210-lab01
# /Users/rossypro/sources/ets/log210/log210-jeu-de-des-node-express-ts/corrections