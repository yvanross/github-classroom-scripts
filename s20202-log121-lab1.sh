# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt

# S20202-LOG121-01-Quiz1-Patron-Stragegie-05-26-2020-08-54-23
# S20202-LOG121-03-Quiz1-Patron-Strategie-05-26-2020-08-52-55
for d in /Users/rossypro/Downloads/S20202-LOG121-04-Quiz1-patron-stragegie-05-26-2020-08-52-14/* ; do
    clear
    pushd $d
    # pandoc -s "$d/src/main/java/PatronStrategie/Comparator/README.md" -o "$d/src/main/java/PatronStrategie/Comparator/README.pdf"
    # open "$d/src/main/java/PatronStrategie/Comparator/README.pdf" &
    mvn test
    sublime "$d/src/main/java/PatronStrategie/Comparator" &
    echo $d
    echo  "Quel est la note de cet étudiant?:"
    read  note
    pushd "/Users/rossypro/Downloads/"
    echo "$d        $note"  >> note.txt
done  