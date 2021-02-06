#  https://cli.github.com/manual/gh_issue_status

if [ -z $1 ] || [ -z $2 ] ; then
  echo "second parameter is the find maxdepth for directory"
  echo './git-list-issues.sh "/Users/rossypro/Downloads"  3' 
  echo './git-list-issues.sh "/Users/rossypro/Downloads/LOG121-strategie" 2'
  echo './git-list-issues.sh "/Users/rossypro/Downloads/LOG210-LAB0"  2' 
  echo './git-list-issues.sh "/Users/rossypro/Downloads/LOG210-LAB1"  2'
else 
  clear
  counter=0
  for group in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$group"
    echo "------------------------------------------------------------------- "
    echo "$counter => $group"
      gh issue list > correction-issues.txt
  done
fi