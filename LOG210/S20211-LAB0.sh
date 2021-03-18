if [ -z $1 ] || [ -z $2 ]; then
  echo "third parameter is the find maxdepth for directory"
  echo './s20211-lab0.sh "/Users/rossypro/Downloads/LOG210-lab0"  2' 
else 
    current_dir=$(pwd)
  clear
  counter=0
  rm $current_dir/S20211-LAB0.txt
  for root in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$root"
    if [ !  -f "README.md" ] ; then
        continue;
    fi
    # pwd
    # echo $root
    # fullpath=$("$root/report_test_stats.json")
    # echo $fullpath
    txt=$(head -c 300 "$root/report_test_stats.json")
    # echo $txt
    IFS=',' read -a arr <<< "$txt"
    nbTotalTest=0
    for s in "${arr[@]}"; do 
        if [[ "$s" =~ "numTotalTests" ]]; then
        IFS=':' read -a value <<< "$s"
        nbTotalTest="${value[1]}"
        fi
        if [[ "$s" =~ "numFailedTests" ]]; then
        IFS=':' read -a value <<< "$s"
        numFailedTests="${value[1]}"
        fi
        
        if [[ "$s" =~ "numPassedTests" ]]; then
        IFS=':' read -a value <<< "$s"
        numPassedTests="${value[1]}"
        fi
    done

    percent_success=$(echo $numPassedTests $nbTotalTest | awk '{printf "%4.1f",(($1-33)/($2-33))*100}')
    name=$(cat README-identification.md | grep nomComplet | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
    moodle_code=$(cat README-identification.md | grep codeMoodle | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
    dirname=$(basename $(pwd))
    echo "$counter => $moodle_code;Lab #0 Remise;$percent_success;$name;$dirname;$nbTotalTest;$numFailedTests;$numPassedTests"
    echo "$moodle_code;Lab #0 Remise;$percent_success;$name;$dirname;$nbTotalTest;$numFailedTests;$numPassedTests" >> $current_dir/S20211-LAB0.txt
  done
  cd $current_dir
  sed  's/Entrer votre code moodle obtenu à partir de Signet//g' S20211-LAB0.txt > S20211-LAB0.tmp
  sed  's/Entrer votre nom//g' S20211-LAB0.tmp > S20211-LAB0.txt
  rm S20211-LAB0.tmp
fi