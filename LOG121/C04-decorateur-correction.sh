# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
# /Users/rossypro/Downloads/LOG121-Strategie

# ./git-reset.sh "/Users/rossypro/Downloads/LOG121-C04-decorateur" 2
# ./git-list-issues.sh "/Users/rossypro/Downloads/LOG121-C04-decorateur" 2 
# ./mvn-install.sh "/Users/rossypro/Downloads/LOG121-C04-decorateur"  2 
# ./md2pdf.sh "/Users/rossypro/Downloads/LOG121-C04-decorateur" 2 README.md 
# ./C04-decorateur.sh "/Users/rossypro/Downloads/LOG121-C04-decorateur" 2
repas_test_ok_str="Est-ce que le test est correct"
array_ok_str="Est-ce que la classe repas inclus un array"
cost_iterator_ok_str="Est ce que la classe repas inclus getCost avec iterateur"
description_iterateur_ok_str="getDescription avec iterateur"
extend_ok_str="classes concrètes et decoratrice extends IRepas ou autre interface"
test_ok_str="Tout les tests passent"
readme_ok_str="2 chiffre: Quelle note donnez vous au readme"

if [ -z $1 ] || [ -z $2 ] ; then
  echo "second parameter is the find maxdepth for directory"
  echo './C04-decorateur-correction.sh "/Users/rossypro/Downloads/LOG121-C04-decorateur" 2'
else 
  clear
  counter=0
  for group in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$group"
    echo "------------------------------------------------------------------- "
    echo "$counter => $group"
    if ! test -f "README.md" ; then
      continue;
    fi
  

    # if [ -f "correction-result.txt" ]; then
    #     continue
    # fi

    # clear
    # cat "./src/test/java/PatronDecorateur/RepasTest.java"
    # echo $repas_test_ok_str
    # read -n 1 repas_test_ok
    # echo "${repas_test_ok} -> ${repas_test_ok_str}" > "correction-result.txt"

    # clear
    # cat "./src/main/java/Decorateur/Repas/Repas.java"
    # echo $array_ok_str
    # read -n 1 array_ok
    # echo "${array_ok} -> ${array_ok_str}" >> "correction-result.txt"

    # echo $cost_iterator_ok_str
    # read -n 1 cost_iterator_ok
    # echo "${cost_iterator_ok} -> ${cost_iterator_ok_str}" >> "correction-result.txt"

    # echo $description_iterateur_ok_str
    # read -n 1 description_iterateur_ok
    # echo "${description_iterateur_ok} -> ${description_iterateur_ok_str}" >> "correction-result.txt"

    
    # clear
    # cat "./src/main/java/Decorateur/Coffee/ICoffee.java"
    # echo $extend_ok_str
    # read -n 1 extend_ok
    # echo "${extend_ok} -> ${extend_ok_str}" >> "correction-result.txt"
    
    # clear
    # cat "correction-test.txt"
    # echo $test_ok_str
    # read -n 1 test_ok
    # echo "${test_ok} -> ${test_ok_str}" >> "correction-result.txt"

    if test -f "README.pdf" ; then
      open README.pdf
    elif test -f "README.md.pdf" ; then
      open README.md.pdf
    else
      open README.md.pdf
    fi
    echo $readme_ok_str
    read -n 1 readme_ok
    if [ $readme_ok = "s"]; then
    sublime correction-result.txt
    end
    read -n 1 readme_ok
    
    # echo $readme_ok_str
    # read -n 2 readme_ok
    # echo "${readme_ok} -> ${readme_ok_str}" >> "correction-result.txt"

    # total=$((repas_test_ok + array_ok + cost_iterator_ok + description_iterateur_ok + extend_ok + test_ok + readme_ok))
    # echo "<total>${total}</total>" >> "correction-result.txt"
    #  echo "TOTAL: ${total}"
  done
fi
