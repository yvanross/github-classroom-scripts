# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
# S20202-LOG121-01-Quiz1-Patron-Stragegie-05-26-2020-08-54-23
# S20202-LOG121-03-Quiz1-Patron-Strategie-05-26-2020-08-52-55
for root in /Users/rossypro/Downloads/* ; do
  for d in $root/* ; do
    cd $d
    # if  ! test  -f "correction.txt"; then
      if test -f "$d/src/main/java/PatronDecorateur/Repas/Repas.java" ; then
        cat "$d/src/main/java/PatronDecorateur/Repas/Repas.java" > correction.txt
      fi
      if test -f "$d/src/test/java/PatronDecorateur/Repas/Repas.java" ; then
        cat "$d/src/main/test/PatronDecorateur/Repas/Repas.java" >> correction.txt
      fi
  
      mvn test | tail -n 25  >> correction.txt
      echo $d  >> correction.txt

      git_repository=$(basename $d)
      cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | grep $git_repository  >> correction.txt

      pandoc $d/src/main/java/PatronDecorateur/Repas/README.md -o $d/README.pdf --filter pandoc-plantuml
      # open $d/README.pdf
      # echo "quel est la note du diagramme de séquence"
      # read note
      # echo "Diagramme de sequence = $note" >> correction.txt 
      pwd
    # fi

  done  
done