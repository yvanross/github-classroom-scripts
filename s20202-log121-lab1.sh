# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
filename="feedback_from_yvan.txt"
note="note.txt"
current_dir=$(pwd)

for root in /Users/rossypro/Downloads/lab1/*; do
  for d in $root/*; do
   if test -f "$d/$filename" ; then
     continue
     fi
    cd $d
    pwd
    simulation=$(find . -type d -name "simulation")
    cd $simulation
    cd ..
    # sublime . &
    javac simulation/*.java > $d/$filename
    java simulation/Simulation 
    

    # if  ! test  -f "correction_quiz2.txt"; then
    git_repository=$(basename $d)
    cd $d

    cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | grep $git_repository >$d/$filename
    current_path=$(pwd) 
    echo $current_path >> $d/$filename
    
    echo "entrer les commentaires"
    read commentaires
    echo $commentaires >> $d/$filename
    echo "Entrer la note de l'étudiant"
    read note_courante
    echo $note >> $d/$filename
    cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | grep $git_repository >> $current_dir/$note
    echo $note_courante >> $current_dir/$note

    # origin=$(git remote get-url --push origin)
    # case "$origin" in *token*)
    #   echo "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    #   new_origin=$(git remote get-url --push origin | cut -c 65-1000)
    #   new_origin=$(echo "git@github.com:$new_origin")
    #   git remote remove origin
    #   git remote add origin $new_origin
    #   ;;
    # esac

    # git add $d/correction.txt
    # git add $d/test_result.txt
    # git commit -am "Correction automatique"
    # git push --set-upstream origin master
  done
done
