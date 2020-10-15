
echo "ATTENTION: cette fonction détruira tout les fichiers locaux, yes pour continuer"
read choix

if [ ! $choix = 'yes' ]
  return
fi
download_path="LOG210-LAB0"
message="update github action V1.0.1"
counter=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for group in $root/*; do
    echo " "
    echo "$counter => $group"
    counter=$(( $counter + 1 ))
    cd $group
    git fetch origin master
    git reset --hard origin/master
    cp -r "/Users/rossypro/sources/ets/log210/S20203-LOG210-Lab0/.github" "$d"
    cp -r "/Users/rossypro/sources/ets/log210/S20203-LOG210-Lab0/package.json" "$d"
    origin=$(git remote get-url --push origin)
    case "$origin" in *token*)
      new_origin=$(git remote get-url --push origin | cut -c 65-1000)
      new_origin=$(echo "git@github.com:$new_origin")
      git remote remove origin
      git remote add origin $new_origin
      ;;
    esac

    
    git add .
    git commit -am "$message"
    git push --set-upstream origin master
  done  
done