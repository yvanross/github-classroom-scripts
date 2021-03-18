if [ -z $1 ] || [ -z $2 ] ; then
  echo "second parameter is the find maxdepth for directory"
  echo './C05-composite-correction.sh "/Users/rossypro/Downloads/LOG121-C05-composite" 2'
else 
  clear
  counter=0
  for group in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$group"
    echo "------------------------------------------------------------------- "
    echo "$counter => $group"
    
    if [ -f "correction-result.txt" ]; then
        echo "Correction-result.txt exist"
        continue
    fi
    if [ !  -f "README.md" ] ; then
        continue;
    fi
    clear
    
    # mvn install
    # mvn -P jacoco test
    # echo "./target/site/jacoco/index.html"
    # open "./target/site/jacoco/index.html"
    # git log | head -n 20 > correction-result.txt

    open README.pdf

    while true
    do
     if [ $q3_note == "99" ]; then
            q3_note="100"
      fi
     total=$(echo $q1_note $q2_note $q3_note $q4_note | awk '{printf "%2.1f",($1)/25*15+($2)/8*5+($3)/100*75+($4)}')
     echo "Q1:${q1_note}/25 Q2:${q2_note}/8 Q3:${q3_note}/100 Q4:${q4_note} total:${total}" 
      echo "Vscode / Test / Jacoco /  1,2,3,4 / mvn Install / Pdf / Next"
      read -n 1 choix
      case $choix in 
        v)
          echo "start vscode"
          code .
          ;;

        t)
          echo "mvn test"
          mvn test 
          # cat "correction-test.txt"
          ;;
        j)
          echo "mvn -P jacoco tst"
          mvn -P jacoco test
          open "./target/site/jacoco/index.html"
          ;;
        i)
          echo "mvn install"
          mvn install
          ;;
        p)
          echo "open README.pdf"
          open README.Pdf
          ;;
        1)
          echo "diagramme de classe logiciel"
          read -n 2 q1_note
          echo "${q1_note} -> diagramme de classe logiciel"
          ;;
        2)
          echo "identification instance des patrons"
          read -n 1 q2_note
          echo "${q2_note} -> diagramme de classe logiciel"
          ;;
        3)
          echo "Complétion du code"
          read -n 2 q3_note
          echo "${q3_note} -> Complétion du code"
          ;;
        4)
          echo "Complétion du code + rapport couverture de code"
          read -n 1 q4_note
          echo "${q4_note} -> Complétion du code + rapport couverture de code"
          ;;
        n)
          break
            ;;
        
     
      esac
    done
    echo "Compute total"
    total=$(echo $q1_note $q2_note $q3_note $q4_note | awk '{printf "%2.1f",($1)/25*15+($2)/8*5+($3)/100*75+($4)}')
     echo "Q1:${q1_note}/25" >> "correction-result.txt"
     echo "Q2:${q2_note}/8" >> "correction-result.txt"
     echo "Q3:${q3_note}/100" >> "correction-result.txt"
     echo "Q4:${q4_note}" >> "correction-result.txt"
     echo "total:${total}" >> "correction-result.txt"
     echo "TOTAL: ${total}"
     q1_note=0
     q2_note=0
     q3_note=0
     q4_note=0

  done
fi
