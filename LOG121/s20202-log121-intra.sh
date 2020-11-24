# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
filename="correction.txt"
note="note.txt"
current_dir=$(pwd)

# echo " " > $current_dir/jacoco_not_generated.txt

for root in /Users/rossypro/Downloads/log121-intra/*; do
  for d in $root/*; do
    cd $d
  d=$(pwd)
    echo $d
   git_repository=$(basename $d)
  # sublime . &
    cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | grep $git_repository > $d/README.md
    echo "\n" >>  $d/README.md
    cat $d/src/test/java/Intra/README.md >> $d/README.md
    mvn -P jacoco test > $d/jacoco.txt
    echo "\n" >>  $d/README.md
    cat $d/jacoco.txt | grep "Tests run" >>  $d/README.md
    
    if test -f "$d/target/site/jacoco/jacoco.csv" ; then
      percent=$(awk -F, \
        '{ instructions += $4 + $5; covered += $5 } END \
        { print covered, "/", instructions, " instructions testées soit", 100*covered/instructions, "% de couverture de test" }' \
        $d/target/site/jacoco/jacoco.csv)
        echo "Vous avez $percent de couverture de test" >>$d/README.md
    else
      echo "jacoco n'a pas généré de rapport $d" 
      echo "jacoco n'a pas généré de rapport $d"  >> $current_dir/jacoco_not_generated.txt
    fi

    git log | head -n 3 >> $d/README.md

    sed -i -e 's#[ ]*@startuml.*#@startuml#g' $d/README.md
    sed -i -e 's#[ ]*@enduml.*#@enduml#g' $d/README.md
    sed -e 's#{[ ]*}##g' $d/README.md > $d/README.md0
    sed 's/ ```/```/g' $d/README.md0 > $d/README.md1 
    sed 's/\\n/ /g' $d/README.md1 > $d/README.md2 
    sed 's/\\r/ /g' $d/README.md2 > $d/README.md 
    rm $d/README.md0  $d/README.md1  $d/README.md2
    pandoc $d/README.md -o $d/README.pdf --filter pandoc-plantuml
    # open $d/README.pdf
      
    mv $d/README.pdf  "$d/$git_repository.pdf"

    sed  -i -e "s#<artifactId>log121</artifactId>#<artifactId>$git_repository</artifactId>#g" $d/pom.xml
  done
done
