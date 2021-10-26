intra-notes.sh

report_name="LOG121-intra.txt"
metric="C07-intra"
if [ -z $1 ] || [ -z $2 ]; then
  echo './intra-notes.sh "/Users/rossypro/Downloads/LOG121-intra" 2' 
else 
    current_dir=$(pwd)
  clear
  rm $current_dir/$report_name
  counter=0
  for root in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$root"
    if [ !  -f "README.md" ] ; then
        continue;
    fi

    note=$(cat correction-result.txt | grep "total"|sed 's/total://g')
    percent_success=$(echo $note | awk '{printf "%4.1f",($1)}')
    name=$(cat README-identification.md | grep nomComplet | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
    moodle_code=$(cat README-identification.md | grep codeMoodle | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
    dirname=$(basename $(pwd))
    echo "$counter => $moodle_code;$metric;$percent_success;$name;$root;"
    echo "$moodle_code;$metric;$percent_success;$name;$root;" >> $current_dir/$report_name
  done
  echo "clean output"
  cd $current_dir
  sed  's/Entrer votre code moodle obtenu à partir de Signet//g' $report_name > calcul.tmp
  sed  's/Entrer votre nom//g' calcul.tmp > $report_name
  rm calcul.tmp
fi