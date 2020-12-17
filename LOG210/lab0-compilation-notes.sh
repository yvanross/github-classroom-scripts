echo "start compilation of notes"
download_path="LOG210-LAB0"
current_directory=$(pwd)

nb_file_processed=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do

  
  for repertoire in $root/*; do
    cd "$repertoire"
    dir_name=$(basename $(dirname "$repertoire"))
    report_name="$current_directory/$dir_name.txt"
    echo $report_name
    nb_file_processed=$(( $nb_file_processed + 1 ))
    if [ -f "report_correction.txt" ]; then
        revision_exist=$(cat report_correction.txt | grep "note-revise =" |  wc -l)
        note_revise=$(cat "report_correction.txt" | grep "note-revise" | awk 'BEGIN { FS = "=" } ; {print $2}' )
        student_name=$(cat "report_correction.txt" | grep "student_name" | awk 'BEGIN { FS = "=" } ; {print $2}') 
        echo $revision_exit
        if [ $revision_exist = '1' ] && [ ! -f "report_correction_final.txt"  ]
        then
        echo "COPIE"
        cp "report_correction.txt" "report_correction_final.txt"
        fi
        echo "$nb_file_processed;$repertoire;$student_name;$note_revise" >> "$report_name"
        echo "$nb_file_processed;$repertoire;$student_name;$note_revise"  

        
    else
      git pull
      if [ ! -f "report_correction.txt" ]; then
    
        echo "$repertoire => report_correction.txt is missing"
        echo ' '

        cd "$repertoire"
        echo "+" > README.md
        rm -rf .github
        cp -r /Users/rossypro/sources/ets/log210/S20203-LOG210-Lab0/.github/ .github
        git add .
        git commit -am "update github directory"
        git push --force

        # echo "check"
        # read -n 1 check
        # git pull
      fi
    fi
    
  done  
done