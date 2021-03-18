
if [ -z $1 ] || [ -z $2 ] ; then
  echo "second parameter is the find maxdepth for directory"
  echo './C04-decorateur-revision.sh "/Users/rossypro/Downloads/LOG121-C04-decorateur" 2'
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

    if test -f "README.pdf" ; then
      open README.pdf
    elif test -f "README.md.pdf" ; then
      open README.md.pdf
    else
      open README.md.pdf
    fi
    echo "s pour sublime"
    read -n 1 readme_ok
    if [[ $readme_ok = "s" ]]; then
        sublime correction-result.txt
        echo "Appuyer sur un touche pour passer à l'élève suivant"
        read -n 1
    fi    
  done
fi
