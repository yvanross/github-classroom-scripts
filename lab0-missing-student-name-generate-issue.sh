echo "start compilation of notes"
download_path="LOG210-LAB0"

nb_file_processed=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for repertoire in $root/*; do
    cd $repertoire
    nb_file_processed=$(( $nb_file_processed + 1 ))
    if [ -f "report_correction.txt" ]; then
        student_name=$(cat "report_correction.txt" | grep "student_name" | awk 'BEGIN { FS = "=" } ; {print $2}') 
        student_name=$(echo $student_name | tr -d '_' | tr -d '*')
        student_name_valid=$(echo $student_name | wc -c)
        if [ $student_name_valid = '1' ]; then
          issues=$(ghi list )
          student_name_issue_valid=$(echo $issues | grep studentName | wc -l || true)
          echo "$student_name_issue_valid must generate issue $repertoire"
          if [ $student_name_issue_valid = '0' ]; then
              ghi open -m "studentName est manquant
              Vérifier dans votre fichier README.md, veuillez l'ajouter le plus rapidement possible. Merci" 
          fi
        fi
        
    fi
  done  
done