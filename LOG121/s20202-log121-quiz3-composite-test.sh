# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
for root in /Users/rossypro/Downloads/quiz3/*; do
  for d in $root/*; do
    cd $d
    pwd
    # if  ! test  -f "correction_quiz2.txt"; then
    git_repository=$(basename $d)
    mvn -P jacoco test >$d/test_result.txt
    rm $d/README.md
    cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | grep $git_repository >$d/correction.txt
    current_path=$(pwd) 
    echo $current_path >> $d/correction.txt
    if grep -q "BUILD FAILURE" $d/test_result.txt; then
      echo "Il y a un BUILD FAILURE" >>$d/correction.txt
    else
      echo "Tout les fichiers sont compilé correctement" >>$d/correction.txt
    fi

    if grep -q "Failed\stests:" $d/test_result.txt; then
      echo "Il y a des tests qui ne fonctionnent pas alors on ne peut pas calculer la couverture de test" >>correction.txt
      cat test_result.txt | grep "expected" >> $d/correction.txt
    fi
    cat test_result.txt | grep "Tests\srun:" | tail -1 >> $d/correction.txt

    if grep -q "Skipping JaCoCo execution due to missing execution data file" $d/test_result.txt; then
      echo "Aucun test d'implémenté" >>$d/correction.txt
    fi

    if test -f "$d/target/site/jacoco/index.html"; then
      if grep -q "<td\sclass=\"ctr2\">100\s%</td>" $d/target/site/jacoco/index.html; then
        echo "Félicitation, vous avez une couverture de test de 100%" >>$d/correction.txt
      else
      percent=$(awk -F, \
    '{ instructions += $4 + $5; covered += $5 } END \
     { print covered, "/", instructions, " instructions testées soit", 100*covered/instructions, "% de couverture de test" }' \
    $d/target/site/jacoco/jacoco.csv)
        echo "Vous avez $percent, il vous reste du travail à faire" >>$d/correction.txt
      fi
    else
      echo "Impossible d'extraire la couverture de test" >>$d/correction.txt
    fi #file exist

    origin=$(git remote get-url --push origin)
    case "$origin" in *token*)
      echo "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
      new_origin=$(git remote get-url --push origin | cut -c 65-1000)
      new_origin=$(echo "git@github.com:$new_origin")
      git remote remove origin
      git remote add origin $new_origin
      ;;
    esac

    git add $d/correction.txt
    git add $d/test_result.txt
    git commit -am "Correction automatique"
    git push --set-upstream origin master
  done
done
