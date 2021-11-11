# cd '/Users/rossypro/Downloads/schedulerproangular'
# git reset --soft HEAD

# commits=$(git log --oneline | tac | awk 'BEGIN {FS=" "}; {print $1}')
# echo $commits

# data="";
# for commit in $commits
# do
   
#    git clean -f
#    echo "cleaned"
#    git reset --soft $commit
#    echo "checkout"
#    gitinspector -f**  > report_gitinspector.txt
#    gitinspector -f** -x author:"Yvan Ross" -x author:elaforge98 -x author:JeremieMalenfant -x author:Olon11 -x author:"Horace ETS" -x author:"prettifier" > report_gitinspector.txt
#   echo "git inspec"
#    commit_data=$(cat report_gitinspector.txt | sed '/Below/,$d' | sed  '1,/changes/d' | sed  "s/[[:>:]][[:space:]][[:<:]]/_/g"  | sed '$ d' | awk 'BEGIN {FS=" "}; {print $1,$5}' | true)
#    echo $commit_data
#    echo "data"
#    data="${data}${commit_data}"
#    echo "after dat"
#    echo $data

#  done