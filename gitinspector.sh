echo "start inspectin git repositories of notes"
download_path="LOG210-LAB1"
current_dir=$(pwd)
report="$current_dir/report_gitinspector.txt"
echo $report
rm -f "$report"
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for repertoire in $root/*; do
    cd "$repertoire"
    echo "$repertoire" >> "$report"
    echo "$repertoire"
    gitinspector > report_gitinspector.txt
    
    cat report_gitinspector.txt | sed '/Below/,$d' | sed  '1,/changes/d' | sed  "s/[[:>:]][[:space:]][[:<:]]/_/g" | sed '/Olon11/d' | sed '$ d' > report_gitinspector_data.txt
    nb_etudiant=$(cat "report_gitinspector_data.txt" | wc -l)

    if [ ! $nb_etudiant = '0' ]; then
      participation_attendu=$(( 100 / $nb_etudiant ))
      # echo "nb_etudiant=$nb_etudiant, participation_attendu=$participation_attendu"
      participation_minimum=$(($participation_attendu / 2))
      participation_maximum=$(($participation_attendu + $participation_minimum))
      
      
      echo "Seuils à dépasser pour générer une alerte : $participation_minimum $participation_maximum " >> "$report"
      echo "Seuils à dépasser pour générer une alerte : $participation_minimum $participation_maximum "
      while read line; do
        etudiant=$(echo "$line" | awk '{print $1}')
        participation_str=$(echo "$line" | awk '{print $5}')
        participation=$( echo ${participation_str%\.*})
    
        if [ "$participation" -lt "$participation_minimum" ] ||  [ "$participation" -gt "$participation_maximum" ]   
        then
          echo "$etudiant participation mesuré=$participation% attendu=$participation_attendu%  *** WARNING ***" >> "$report"
          echo "$etudiant participation mesuré=$participation% attendu=$participation_attendu%  *** WARNING ***"
        else
          echo "$etudiant participation mesuré=$participation% attendu=$participation_attendu% " >> "$report"
          echo "$etudiant participation mesuré=$participation% attendu=$participation_attendu% "
        fi
      done < "report_gitinspector_data.txt"
      echo  " " >> "$report"
      echo  " "
      rm -f "report_gitinspector_data.txt"
    fi

     
  done  
done