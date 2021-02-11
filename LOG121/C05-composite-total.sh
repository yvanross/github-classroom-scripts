couverture_test_str="Quel est le pourcentage de couverture de test"
remove_song_list_generator="Vouslez vous détruire SongListGenerator.java"

if [ -z $1 ] || [ -z $2 ] ; then
  echo "second parameter is the find maxdepth for directory"
  echo './C05-composite-total.sh "/Users/rossypro/Downloads/LOG121-C05-composite" 2'
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
    

    echo "./target/site/jacoco/index.html"
    open "./target/site/jacoco/index.html"
    
    while true
    do
      echo "Sublime / Test / Jacoco / Delete SongListGenerator delete / Note / Index.html / Ls"
      read -n 1 choix
      case $choix in 
        s)
          sublime .
          ;;
        t)
          mvn test > "correction-test.txt"
          open "correction-test.txt"
          ;;
        j)
          mvn -P jacoco test
          open "./target/site/jacoco/index.html"
          ;;
        d)
          rm "./src/main/java/Composite/Song/SongListGenerator.java"
          mvn -P jacoco test
          open "./target/site/jacoco/index.html"
          ;;
        i)
          open "./target/site/jacoco/index.html"
          ;;
        n)
          echo $couverture_test_str
          read -n 2 couverture_test_ok
          if [ $couverture_test_ok == "99" ]; then
            couverture_test_ok="100"
          fi
          echo "${couverture_test_ok} -> ${couverture_test_str}" > "correction-result.txt"
          break
            ;;
        l)
          ls
          ;;
     
      esac
    done
    echo "Compute total"
    total=$((couverture_test_ok))
    echo "<total>${total}</total>" >> "correction-result.txt"
     echo "TOTAL: ${total}"
  done
fi
