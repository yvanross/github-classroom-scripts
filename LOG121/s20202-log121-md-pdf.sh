# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
home="mp4"
current_dir=$(pwd)

for root in "/Users/rossypro/Downloads/$home/*"; do
  cd $root
  for f in *\ *; do mv "$f" "${f// /_}"; done
  
  for md in $root/*.md; do
    echo "----------------------------------------------------";
    echo "$md"
    if ! test -f "$md.backup" ; then
      cp  "$md" "$md.backup"
    fi
   
    sed -i -e 's#[ ]*@startuml.*#@startuml#g' "$md"
    sed -i -e 's#[ ]*@enduml.*#@enduml#g' "$md"
    sed -e 's#{[ ]*}##g' "$md" > md0
    sed 's/ ```/```/g' md0 > md1
    sed 's/\\n/ /g' md1 > md2
    sed 's/\\r/ /g' md2 > "$md" 
    rm "md0"  "md1"  "md2"
    pandoc "$md" -o "$md.pdf" --filter pandoc-plantuml  
  done
done
