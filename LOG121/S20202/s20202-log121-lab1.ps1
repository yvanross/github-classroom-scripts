# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
$filename="feedback_from_yvan.txt"
$note="note.txt"
$current_dir=$(pwd)

#for root in /Users/rossypro/Downloads/lab1/*; do

foreach($root in  (get-childitem '\\Mac\Home\Downloads\LOG121-lab1').fullname) {
    Write-Output $root
 
  foreach ($d in (get-childitem $root).fullname) {
      Write-output $d
    cd $d
    $src = Join-Path -Path $d -ChildPath "log121-simulation-squelette/src"
    write-output $src
    cd $src
    $feedback  = Join-Path -Path $d -ChildPath $filename
    write-output $feedback

    javac simulation\*.java  | out-file -filepath $feedback -append
    Start-process -filepath java -ArgumentList simulation\Simulation.java 
    

    # if  ! test  -f "correction_quiz2.txt"; then
   # git_repository=$(basename $d)
    $git_repository = Split-Path -path $d -Leaf
    write-output $git_repository
    $g01 = Join-Path -Path $current_dir -ChildPath '/etudiants/s20202-log121-01-github-nom-ets.txt'
    $g03 = Join-Path -Path $current_dir -ChildPath '/etudiants/s20202-log121-03-github-nom-ets.txt'
    $g04 = Join-Path -Path $current_dir -ChildPath '/etudiants/s20202-log121-04-github-nom-ets.txt'


  #  cat $g01 $g03 $g04 | select-string -pattern $git_repository  | out-file  -filepath  $feedback -append
  
    $commentaires = read-host -prompt "Entrer vos commentaires"
    $note = read-host -prompt "Entrer la note de l'étudiant"
    add-content $feedback "--------------"
    add-content $feedback "$(Get-date) -  $commentaires"
    add-content $feedback "$(Get-date) - Note: $note"
   # read note_courante
 #   echo $note >> $d/$filename
  #  cat /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-01-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-03-github-nom-ets.txt /Users/rossypro/sources/ets/log121/log121-scripts/etudiants/s20202-log121-04-github-nom-ets.txt | select-string -pattern $git_repository >> $current_dir/$note
   # echo $note_courante >> $current_dir/$note

    # origin=$(git remote get-url --push origin)
    # case "$origin" in *token*)
    #   echo "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    #   new_origin=$(git remote get-url --push origin | cut -c 65-1000)
    #   new_origin=$(echo "git@github.com:$new_origin")
    #   git remote remove origin
    #   git remote add origin $new_origin
    #   ;;
    # esac

    # git add $d/correction.txt
    # git add $d/test_result.txt
    # git commit -am "Correction automatique"
    # git push --set-upstream origin master
    }
}
cd $current_dir

cd "C:\Users\rossypro\sources\LOG121-scripts"