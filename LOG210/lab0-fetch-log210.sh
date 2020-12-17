echo "start automatic correction of LOG210-lab0"
download_path="LOG210-LAB0"

echo "ATTENTION: cette fonction détruira tout les fichiers locaux, yes pour continuer"
read choix

if [ ! $choix = 'yes' ]
  return
fi

counter=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for group in $root/*; do
    cd "$group"
    echo "$counter -> $group"
    counter=$(( $counter + 1 ))
    git fetch origin master
    git reset --hard origin/master
  done  
done