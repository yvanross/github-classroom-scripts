echo "start compilation of notes"
download_path="LOG210-LAB0"
current_dir=$(pwd)
nb_file_processed=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for repertoire in $root/*; do
    cd "$repertoire"
    nb_file_processed=$(( $nb_file_processed + 1 ))
    name=$(basename "$repertoire")
    code=$(cat "$current_dir/s20203-log210-students.txt" | grep $name |  awk -F, '{print $1}')

    if [ -z "$code" ]; then
      echo "$repertoire -> $code"
    fi
    
    # if [ -f "report_correction.txt" ]; then
    #     cd "$repertoire"
        
    #     student_name=$(cat "README.md" | grep "studentName"  | awk -FstudentName '{print $2}' | tr -d '<'| tr -d '>' | tr -d '/' | sed 's/ //') 
    #     echo "$student_name"
    #     student_name=$(echo $student_name | tr -d '*')
    #     student_name_valid=$(echo $student_name | wc -l)
    #     if [ $student_name_valid = '1' ]; then
    #       issues=$(ghi list )
    #       student_name_issue_valid=$(echo $issues | grep studentName | wc -l || true)
    #       echo "$student_name_issue_valid must generate issue $repertoire"
    #       # if [ $student_name_issue_valid = '0' ]; then
    #           # ghi open -m "studentName est manquant
    #           # Vérifier dans votre fichier README.md, veuillez l'ajouter le plus rapidement possible. Merci" 
    #       # fi
    #     else
    #     echo "$repertoire -> student name missing"
    #     fi
        
    # fi
  done  
done