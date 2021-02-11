# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
filename="correction.txt"
note="note.txt"
current_dir=$(pwd)
# reset file content1
echo " " > $current_dir/jacoco_not_generated.txt

for root in /Users/rossypro/Downloads/log121-intra/*; do
  for d in $root/*; do
    cd $d
    git_repository=$(basename $d)
    d=$(pwd)
    echo $d
   if test -f "$d/target/site/jacoco/jacoco.csv" ; then
      percent=$(awk -F, \
        '{ instructions += $4 + $5; covered += $5 } END \
        { print 100*covered/instructions, "% " }' \
        $d/target/site/jacoco/jacoco.csv)
        echo "$percent -> $d" >> $current_dir/coverage.txt
        echo "$percent -> $d" >> $d/README.md
    else
        echo "0% -> $d" >> $current_dir/coverage.txt
        echo "0% -> $d" >> $d/README.md
    fi

   pandoc $d/README.md -o "$d/$git_repository.pdf" --filter pandoc-plantuml
   

   
  done
done
