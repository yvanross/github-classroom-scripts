
# $1 is the path in /Users/rossypro/Downloads
message="add gitinspector info"
counter=0
for root in "/Users/rossypro/Downloads/$1/*"; do
  for group in $root/*; do
    echo " "
    echo "$counter => $group"
    counter=$(( $counter + 1 ))
    cd $group
    git pull --no-edit
  done  
done