echo "start automatic correction of LOG210-lab0"
download_path="LOG210-LAB0"

#  cd "/Users/rossypro/Downloads/LOG210-LAB0/S20203-LOG210-01-LAB0-10-11-2020-05-51-52/BobbySystem"

nb_file_processed=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for repertoire in $root/*; do
    cd $repertoire
    revision_exist=$(cat report_correction.txt | grep "note-revise =" |  wc -l)
    
    if [ $revision_exist = '0' ]; then
      file_counter=0
      echo " "
      echo "$nb_file_processed => $repertoire"
      nb_file_processed=$(( $nb_file_processed + 1 ))
    
      cat report_correction.txt | grep "ERROR" > errors.txt
      input=errors.txt
      while IFS= read -r error 
      do
        filename=$(echo $error | awk 'BEGIN { FS = "#" } ; {print $2}')
        missing_text=$(echo $error | awk 'BEGIN { FS = "[" } ; {print $2}' | awk 'BEGIN { FS = "]" } ; {print $1}')
      
        rm -f "error_verification.txt"
        
        cat $filename | while read line 
        do
          nbWord=$(echo $line | wc -w | tr -d "[:space:]" )
          if [ ! $nbWord = '0' ]; then
            word_count=0
            words=$(echo $missing_text | tr " " "\n")
            for word in $words
            do 
              count=$(echo $line | grep $word | wc -l)
              word_count=$(( $word_count + $count ))
            done
            echo "$word_count; $line" >> error_verification.txt
            # echo "$word_count; $line" 
          fi

        done
        if test -f "error_verification.txt"; then
          sort -nr error_verification.txt > error_verification_sorted.txt
          echo "$(echo $missing_text | wc -w | tr -d '[:space:]') ; $missing_text" > temp.txt
          echo "-----------------------------------------------------------------" >> temp.txt
          
          cat error_verification_sorted.txt >> temp.txt
          head 10 temp.txt > "report_error_$file_counter.txt"
          file_counter=$(($file_counter + 1))
          echo "report_error_$file_counter.txt generated"
        fi
      done < "$input"
    fi
  done  
done