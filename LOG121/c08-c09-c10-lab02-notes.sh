
report_name="LOG121-notes.txt"

metrics=("C08-memento":"/Users/rossypro/Downloads/LOG121-C08-memento"
        "C09-mediateur":"/Users/rossypro/Downloads/LOG121-C09-mediateur"
        "C10-MP1":"/Users/rossypro/Downloads/LOG121-C10-MP1"
        "Lab02":"/Users/rossypro/Downloads/LOG121-LAB2")


if [ -z $1 ]; then
  echo './c08-c09-c10-notes.sh  2' 
else 
  current_dir=$(pwd)
  clear
  rm $current_dir/$report_name 

  for metric in "${metrics[@]}"; do 
    metric_name="${metric%%:*}"
    url="${metric##*:}"
    for root in $(find $url -maxdepth $1 -type d); do
        counter=$(( $counter + 1 ))
        cd "$root"
        if [ !  -f "README.md" ] ; then
            continue;
        fi
           if [ !  -f "correction.txt" ] ; then
            continue;
        fi
        note=$(cat correction.txt| awk 'BEGIN {FS=":"}; {printf "%4.1f",($2)}')
        printf "%s likes to %s.\n" "$metric_name" "$root"

        # note=$(cat correction-result.txt | grep "<total>"|sed 's/<total>//g'|sed 's/<\/total>//g')
        # note=$(echo $note | awk '{printf "%4.1f",($1)}')
        etudiant=$(cat README.md | grep codeMoodle | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
        for code in $etudiant; do
          echo "$code;$metric_name;$note;"
          echo "$code;$metric_name;$note;" >> $current_dir/$report_name
        done
     

    done
  done
fi