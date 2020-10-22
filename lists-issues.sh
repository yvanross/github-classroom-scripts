 echo "start compilation of notes"
download_path="LOG210-LAB0"

nb_file_processed=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for repertoire in $root/*; do
    cd "$repertoire"
    issues=$(ghi list)
    none_issues=$(echo $issues | grep "open issues None" | wc -l || true)
    if [ $none_issues = '0' ]; then
        echo "$repertoire"
        echo $issues
        echo " "
   fi
  done  
done