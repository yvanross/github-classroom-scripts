# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
filename="correction.txt"
note="note.txt"
current_dir=$(pwd)

# echo " " > $current_dir/jacoco_not_generated.txt

for root in /Users/rossypro/Downloads/log121-intra/*; do
  for d in $root/*; do
    cd $d
    # $current_dir
 
  done
done


#  if test -f "$d/$filename" ; then


    # origin=$(git remote get-url --push origin)
    # case "$origin" in *token*)
    #   echo "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    #   new_origin=$(git remote get-url --push origin | cut -c 65-1000)
    #    fi
    #   new_origin=$(echo "git@github.com:$new_origin")
    #   git remote remove origin
    #   git remote add origin $new_origin
    #   ;;
    # esac

    # git add $d/correction.txt
    # git add $d/test_result.txt
    # git commit -am "Correction automatique"
    # git push --set-upstream origin master