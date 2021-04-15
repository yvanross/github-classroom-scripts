  echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

echo "generate gitinspector report for Charge de laboratoire"
if [ -z $1 ]; then
echo './git-inspector.sh "/Users/rossypro/Downloads/LOG210-LAB1"'
else
  clear
  current_dir=$(pwd)
  report="$current_dir/report_gitinspector.txt"
  rm -f "$report"
  for root in "$1/*"; do
    for repertoire in $root/*; do
      cd "$repertoire"

      tplant --input ./**/*.ts --output class_extracted_from_code.svg
      gitinspector -f** -Tw -x author:"Yvan Ross" -x author:elaforge98 -x author:sebchampoux -x author:islemsaidani -x author:Olon11 -x author:hinderrahmouni -x author:"prettifier" > report_gitinspector.txt

      cat report_gitinspector.txt | sed '/Below/,$d' | sed  '1,/changes/d' | sed  "s/[[:>:]][[:space:]][[:<:]]/_/g"  | sed '$ d' > report_gitinspector_data.txt
      nb_etudiant=$(cat "report_gitinspector_data.txt" | wc -l)

      if [ ! $nb_etudiant = '0' ]; then
        participation_attendu=$(( 100 / $nb_etudiant ))
         participation_minimum=$(($participation_attendu / 2))
        participation_maximum=$(($participation_attendu + $participation_minimum))

        echo " " 
        echo "$repertoire => Seuis: [$participation_minimum $participation_maximum]" 


        echo " " >> "$report"
        echo "$repertoire => Seuis: [$participation_minimum $participation_maximum]" >> "$report"
       echo "$repertoire => Seuis: [$participation_minimum $participation_maximum]" >> "$report"
        
        while read line; do
          etudiant=$(echo "$line" | awk '{print $1}')
          participation_str=$(echo "$line" | awk '{print $5}')
          participation=$( echo ${participation_str%\.*})
      
          if [ "$participation" -lt "$participation_minimum" ] ||  [ "$participation" -gt "$participation_maximum" ]   
          then
            echo "$etudiant mesuré=$participation% attendu=$participation_attendu%  *** WARNING ***" >> report_gitinspector.txt
            echo "$etudiant mesuré=$participation% attendu=$participation_attendu%  *** WARNING ***" >> "$report"
            echo "$etudiant mesuré=$participation% attendu=$participation_attendu%  *** WARNING ***"
          else
            echo "$etudiant mesuré=$participation% attendu=$participation_attendu% " >> report_gitinspector.txt
            echo "$etudiant mesuré=$participation% attendu=$participation_attendu% " >> "$report"
            echo "$etudiant mesuré=$participation% attendu=$participation_attendu% "
          fi
        done < "report_gitinspector_data.txt"
        echo  " " >> report_gitinspector.txt
        echo  " " >> "$report"
        echo  " "

        rm -f "report_gitinspector_data.txt"
      fi
    done  
  done
fi