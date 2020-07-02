# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
current_dir=$(pwd)

# echo " " > $current_dir/jacoco_not_generated.txt

for root in /Users/rossypro/Downloads/log121-intra/*; do
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
    git commit -am "Correction Intra par Yvan"
    git push --set-upstream origin master
  done
done
