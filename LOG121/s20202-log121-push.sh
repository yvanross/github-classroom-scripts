download_path="log121-devoir2"
message="Correction devoir #2 réalisé par Yvan Ross"

for root in "/Users/rossypro/Downloads/$download_path/*"; do
  # Itérer dans tous les projets git
  for d in $root/*; do
    cd $d
    echo $d
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
