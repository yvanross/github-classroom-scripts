#!/bin/bash
globalOptions="--localize-output --grading --format=html"
authorsToExcludeArray=("Benjamin Le" "Yvan Ross")
reportPrefix="ContributionsÉquipe"
reportTests="${reportPrefix}Test.html"
reportModels="${reportPrefix}Modèles.html"
reportTypeScript="${reportPrefix}TypeScript.html"
reportViews="${reportPrefix}Views.html"
reportDocumentation="${reportPrefix}Docs.html"

# modified from https://gist.github.com/JamieMason/4761049
function npm_package_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  npm list -g 2>/dev/null | grep $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

if [ $(npm_package_is_installed gitinspector) ]
then
    if [ "$1" != "" ]; then
        echo "gitinspector running on $1 : patience..."
    else
        echo "Usage: $0 path/to/team/git/repo"
        exit
    fi
    # Build the commands up in parts
    authorsToExclude=""
    for author in "${authorsToExcludeArray[@]}"
    do
      authorsToExclude="${authorsToExclude} -x \"author:${author}\""
    done
    # Contributions sur le plan tests
    command="gitinspector -x 'file:^(?!(test))' -f ts ${globalOptions} ${authorsToExclude} $1 > \"$reportTests\" && echo \"$reportTests\""
    eval $command
    # Contributions sur le plan modèles
    command="gitinspector -f puml,plantuml ${globalOptions} ${authorsToExclude} $1 > \"$reportModels\" && echo \"$reportModels\""
    eval $command
    # Contributions sur le plan documentation
    command="gitinspector -f md ${globalOptions} ${authorsToExclude} $1 > \"$reportDocumentation\" && echo \"$reportDocumentation\""
    eval $command
    # Contributions sur le plan TypeScript
    command="gitinspector -x 'file:^(?!(src))' -f ts ${globalOptions} ${authorsToExclude} $1 > \"$reportTypeScript\" && echo \"$reportTypeScript\""
    eval $command
    # Contributions sur le plan Views
    command="gitinspector -x 'file:^(?!(views))' -f pug ${globalOptions} ${authorsToExclude} $1 > \"$reportViews\" && echo \"$reportViews\""
    eval $command
else
    echo 'Pour utliser ce script, il faut installer le package `gitinspector` avec `npm install -g gitinspector`.'
fi
