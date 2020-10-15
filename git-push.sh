
download_path="LOG210-LAB1"
message="correction du rapport préliminaire"
counter=0
for root in "/Users/rossypro/Downloads/$download_path/*"; do
  for group in $root/*; do
    echo " "
    echo "$counter => $group"
    counter=$(( $counter + 1 ))
    cd $group
    rm -f "jest.json"
    git pull origin master --no-edit
    git add .
    git commit -am "$message"
    git push --set-upstream origin master
  done  
done