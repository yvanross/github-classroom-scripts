
GHUSER ="cc-yvanross"
GITHUB_API_TOKEN="regarder dan mon trousseau d'accès: github cc-yvanross access all scope"
 
curl "https://api.github.com/orgs/$GHUSER/repos?access_token=$GITHUB_API_TOKEN&per_page=100" | grep -w ssh_url | awk 'BEGIN {FS=": "}; {print "substr($2, 1, length($2)-1)\n"}' 

curl "https://api.github.com/orgs/$GHUSER/repos?access_token=$GITHUB_API_TOKEN&per_page=100" | grep -w ssh_url | awk  -v g="git clone " 'BEGIN {FS=": "}; {new_var=substr($2, 1, length($2)-1);print g new_var}'


curl -X DELETE -H "Authorization: token $GITHUB_API_TOKEN" "https://api.github.com/repos/$GHUSER/delete_test"