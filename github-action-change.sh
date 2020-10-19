if [ -z $1 ] || [ -z $2 ]; then
  echo './github-action-change.sh "/Users/rossypro/Downloads/LOG210-LAB0" ".github/workflows/main.yml" "s/\[push, workflow_dispatch\]/\[workflow_dispatch\]/"' 
  echo './github-action-change.sh "/Users/rossypro/Downloads/LOG210-LAB0" ".github/workflows/main.yml" "s/\[workflow_dispatch\]/\[push, workflow_dispatch\]/"' 
else 
  counter=0
  for root in "$1/*"; do
    for group in $root/*; do
      counter=$(( $counter + 1 ))
      cd $group
      echo "------------------------------------------------------------------- "
      echo "$counter => $group"
      sed -i.bak "$3" "$2"
      # cat "$group/$2"
      # break;
    done  
  done
fi