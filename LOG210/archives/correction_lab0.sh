dir=$(pwd)
fullpath=$("$dir/report_test_stats.json")
txt=$(head -c 300 $fullpath)
IFS=',' read -a arr <<< "$txt"
nbTotalTest=0
for s in "${arr[@]}"; do 
    if [[ "$s" =~ "numTotalTests" ]]; then
       IFS=':' read -a value <<< "$s"
       nbTotalTest="${value[1]}"
    fi
    if [[ "$s" =~ "numFailedTests" ]]; then
       IFS=':' read -a value <<< "$s"
       numFailedTests="${value[1]}"
    fi
    
    if [[ "$s" =~ "numPassedTests" ]]; then
       IFS=':' read -a value <<< "$s"
       numPassedTests="${value[1]}"
    fi
done

# echo  "nbTotalTest = $nbTotalTest"
# echo  "numFailedTests = $numFailedTests"
# echo  "numPassedTests = $numPassedTests"

percent_success=$(echo $numPassedTests $nbTotalTest | awk '{printf "%4.1f",(($1-33)/($2-33))*100}')
name=$(cat README-identification.md | grep nomComplet | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
moodle_code=$(cat README-identification.md | grep codeMoodle | awk 'BEGIN { FS = ">" } ; {print $2}' | awk 'BEGIN {FS="<"}; {print $1}')
dirname=$(basename $(pwd))
echo "-------------------------------"
echo "$moodle_code;Lab #0 Remise;$percent_success;$name;$dirname;$nbTotalTest;$numFailedTests;$numPassedTests"
echo "$moodle_code;Lab #0 Remise;$percent_success;$name;$dirname;$nbTotalTest;$numFailedTests;$numPassedTests" >> S20211-LAB0.txt

