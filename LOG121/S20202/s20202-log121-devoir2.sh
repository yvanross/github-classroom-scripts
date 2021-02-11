# display line with one field only
   git_repository=$(basename $d)

# cat *.txt | awk 'NF == 1' >> missing.txt
# filename="feedback_from_yvan.txt"
# note="note.txt"
current_dir=$(pwd)

for root in /Users/rossypro/Downloads/log121-devoir2/*; do
  for d in $root/*; do
    cd $d
    pwd
    # if test -f "$d/test_result.txt" ; then
    #  continue
    # fi
    git_repository=$(basename $d)
    # sed  -i -e "s#<artifactId>log121</artifactId>#<artifactId>$git_repository</artifactId>#g" $d/pom.xml

    # rm "$d"/src/test/java/Devoir2/*.java
    # cp "$current_dir/../S20202-log121-devoir2/src/test/java/devoir2/ValidationTest.java" "$d/src/test/java/devoir2/ValidationTest.java"
    mvn test > $d/mvn_result.txt
    cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | grep $git_repository > "$d/test_result.txt"
    cat "$d/mvn_result.txt" | grep "Tests run" >>  "$d/test_result.txt"
     
  done
done
