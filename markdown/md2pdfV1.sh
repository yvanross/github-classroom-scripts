
    


if [ -z $1 ] || [ -z $2 ]; then
  echo "third parameter is the find maxdepth for directory"
  echo './md2pdf.sh "/Users/rossypro/Downloads/LOG121-strategie" 2 README.md '
else 
  clear
  counter=0
  for d in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$d"
    echo "------------------------------------------------------------------- "
    echo "$counter => $d"
    if ! test -f "$d/$3.pdf"; then
        sed -i -e 's#[ ]*@startuml.*#@startuml#g' $d/$3
        sed -i -e 's#[ ]*@enduml.*#@enduml#g' $d/$3
        sed -e 's#{[ ]*}##g' $d/$3 > $d/TEMP.md0
        sed 's/ ```/```/g' $d/TEMP.md0 > $d/TEMP.md1 
        sed 's/\\n/ /g' $d/TEMP.md1 > $d/TEMP.md2 
        sed 's/\\r/ /g' $d/TEMP.md2 > $d/TEMP.md 

        echo "Create -> $directory/README.pdf"
        pandoc $d/TEMP.md -o $d/$3.pdf --filter pandoc-plantuml
        rm $d/TEMP.md $d/TEMP.md0  $d/TEMP.md1  $d/TEMP.md2
    fi
  done
fi