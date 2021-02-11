if [ -z $1 ] || [ -z $2 ]; then
  echo './c04-decorateur-notes.sh "/Users/rossypro/Downloads/LOG121-C04-decorateur" 2' 
else 
    current_dir=$(pwd)
  clear
  rm $current_dir/S20211-C04.txt
  counter=0
  for root in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$root"
    if [ !  -f "README.md" ] ; then
        continue;
    fi

    note=$(cat correction-result.txt | grep "<total>"|sed 's/<total>//g'|sed 's/<\/total>//g')
    percent_success=$(echo $note 34 | awk '{printf "%4.1f",(($1)/($2))*100}')
    name=$(cat README-identification.md | grep nomComplet | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
    moodle_code=$(cat README-identification.md | grep codeMoodle | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
    dirname=$(basename $(pwd))
    echo "$counter => $moodle_code;C04-decorateur;$percent_success;$name;$root;"
    echo "$moodle_code;C04-decorateur;$percent_success;$name;$root;" >> $current_dir/S20211-C04.txt
  done
  echo "clean output"
  cd $current_dir
  sed  's/Entrer votre code moodle obtenu à partir de Signet//g' S20211-C04.txt > calcul.tmp
  sed  's/Entrer votre nom//g' calcul.tmp > S20211-C04.txt
  rm calcul.tmp
fi