clear
txt=$(head -c 300 /Users/rossypro/Downloads/LOG210-lab0/S20211-LOG210-01-LAB0-01-09-2021-11-11-49/ArthurBousquet/report_test_stats.json)
IFS=',' read -a arr <<< "$txt"
nbTotalTest=0
for s in "${arr[@]}"; do 
  echo "$s"
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
echo "-------------------------------"

echo  "nbTotalTest = $nbTotalTest"
echo  "numFailedTests = $numFailedTests"
echo  "numPassedTests = $numPassedTests"

# percent_success=$(( $numPassedTests  / $nbTotalTest )).$(( ($numPassedTests  * 100 / $nbTotalTest ) % 100 ))
# percent_success=$(echo $percent_success 100 | awk '{printf "%4.2f",$1*$2}')
percent_success=$(echo $numPassedTests $nbTotalTest | awk '{printf "%4.1f",(($1-33)/($2-33))*100}')
echo "percent_success =$percent_success"

