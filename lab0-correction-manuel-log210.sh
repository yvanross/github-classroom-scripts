echo "start automatic correction of LOG210-lab0"
download_path="LOG210-LAB0"

#  cd "/Users/rossypro/Downloads/LOG210-LAB0/S20203-LOG210-01-LAB0-10-11-2020-05-51-52/BobbySystem"

nb_file_processed=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for repertoire in $root/*; do
    cd "$repertoire"
    nb_file_processed=$(( $nb_file_processed + 1 ))
    if [ -f "report_correction.txt" ]; then
      revision_exist=$(cat report_correction.txt | grep "note-revise =" |  wc -l)
    
      if [ $revision_exist = '0' ]; then
        counter=0
        for f in report_error*.txt
        do
        clear
          echo "file_counter=$nb_file_processed"
          cat "$repertoire/$f"
          read -n 1 choix
          if [ $choix = 'o' ]; then
            counter=$(( $counter + 1 ))
            echo "ACCEPTED" >>  $f
          else
            echo "REJECTED" >>  $f
          fi
        done
        total=$(cat report_correction.txt | grep "total=" |  awk 'BEGIN { FS = "=" } ; {print $2}')
        pass=$(cat report_correction.txt | grep "pass=" |  awk 'BEGIN { FS = "=" } ; {print $2}')
      
        pass=$(( $pass + $counter))
        note=$(( $pass  / $total )).$(( ($pass  * 100 / $total ) % 100 ))

        echo "pass-with-manual-verification=$pass"
        echo "note-revise = $note"
        echo "File counter = $counter"

        echo "pass-with-manual-verification=$pass" >> report_correction.txt

        echo "note-revise = $note" >> report_correction.txt

      fi
    else
      echo "report_error.txt do not exist"
    fi
    
  done  
done