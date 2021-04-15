
report_name="log210-notes.txt"


if [ -z $1 ]; then
  echo './LAB01-notes.sh /Users/rossypro/Downloads/LOG210-lab01 2' 
else 
    current_dir=$(pwd)
    clear
    rm $current_dir/$report_name 

   for root in $(find $1 -maxdepth $2 -type d); do
      counter=$(( $counter + 1 ))
        cd "$root"
        if [ !  -f "README.md" ] ; then
            continue;
        fi
        # note=$(cat correction.txt| awk 'BEGIN {FS=":"}; {printf "%4.1f",($2)}')
        printf "%s likes to %s.\n" "$metric_name" "$root"

        # note=$(cat correction-result.txt | grep "<total>"|sed 's/<total>//g'|sed 's/<\/total>//g')
        # note=$(echo $note | awk '{printf "%4.1f",($1)}')
        etudiant=$(cat README-identification.md | grep codeMoodle | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
        for code in $etudiant; do
            echo "$code;$metric_name;$note;"
            echo "$code;$metric_name;$note;" >> $current_dir/$report_name
        done

        ruby notes.rb
        
     done

fi