# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
# S20202-LOG121-01-Quiz1-Patron-Stragegie-05-26-2020-08-54-23
# S20202-LOG121-03-Quiz1-Patron-Strategie-05-26-2020-08-52-55
for root in /Users/rossypro/Downloads/quiz2/* ; do
  for d in $root/* ; do
    cd $d
    # if  ! test  -f "correction_quiz2.txt"; then
      echo "Vos tests pour le quiz #2 ne fonctionnent pas" > correction_quiz2.txt
      echo "---------------------------------------------" >> correction_quiz2.txt
      if test -f "$d/src/main/java/PatronDecorateur/Repas/Repas.java" ; then
        cat "$d/src/main/java/PatronDecorateur/Repas/Repas.java" >> correction_quiz2.txt
      fi
      if test -f "$d/src/test/java/PatronDecorateur/Repas/Repas.java" ; then
        cat "$d/src/test/java/PatronDecorateur/Repas/Repas.java" >> correction_quiz2.txt
      fi
      rm  "$d/src/test/java/PatronStrategie/Comparator/PatronStrategieComparatorTest.java"  

      git_repository=$(basename $d)

      # Verify if the test is successful
      # a=($( mvn -Dtest=RepasTest#repasTest test | grep "Failures: 0" | wc -w))
      a="22"
      TEST_WITH_NO_FAILURE="22"
      if [ $a = $TEST_WITH_NO_FAILURE ]; then     
        echo "Test is successful" ; 
        rm correction_quiz2.txt
      else      
        # mvn -Dtest=RepasTest#repasTest test  >> correction_quiz2.txt
         cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | grep $git_repository  >> correction_quiz2.txt
      fi

      echo " " >> $d/src/main/java/PatronDecorateur/Repas/README.md
      cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | grep $git_repository  >> $d/src/main/java/PatronDecorateur/Repas/README.md
      pandoc $d/src/main/java/PatronDecorateur/Repas/README.md -o $d/README2.pdf --filter pandoc-plantuml
     
    
      # open $d/README.pdf
      # echo "quel est la note du diagramme de séquence"
      # read note
      # echo "Diagramme de sequence = $note" >> correction_quiz2.txt 
      pwd
    # fi

  done  
done