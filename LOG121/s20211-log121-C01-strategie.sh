# display line with one field only
# cat *.txt | awk 'NF == 1' >> missing.txt
# /Users/rossypro/Downloads/LOG121-Strategie

# ./git-reset.sh "/Users/rossypro/Downloads/LOG121-strategie" 2
# ./git-list-issues.sh "/Users/rossypro/Downloads/LOG121-strategie" 2 
# ./mvn-jacoco.sh "/Users/rossypro/Downloads/LOG121-strategie/"  2 
# ./md2pdf.sh "/Users/rossypro/Downloads/LOG121-strategie" 2 README.md 
# ./s20211-log121-C01-strategie.sh "/Users/rossypro/Downloads/LOG121-strategie" 2
if [ -z $1 ] || [ -z $2 ] ; then
  echo "second parameter is the find maxdepth for directory"
  echo './s20211-log121-C01-strategie.sh "/Users/rossypro/Downloads/LOG121-strategie" 2'
else 
  clear
  counter=0
  for group in $(find $1 -maxdepth $2 -type d); do
    counter=$(( $counter + 1 ))
    cd "$group"
    echo "------------------------------------------------------------------- "
    echo "$counter => $group"
    if test -f "correction-commentaires.txt" ; then
    continue;
    fi
  
    open README.pdf
    open README.md.pdf
    open correction-test.txt
    open ./src/main/java/PatronStrategie/Comparator/ComparatorNomSalaire.java
    while [ true ]
    do
      echo "Entrer vos commentaires"
      read commentaires
      case $commentaires in
        h)
          echo "ae - ArrayList<Employe> est manquand dans votre diagramme de séquence"
          echo "ac - L'association pour la crétion d'instance est de type --> "
          echo "bt - Bon travail, vous avez remplis presque tout les critères" 
          echo "cs - Collection.sort(employes,ageComparator) est manquant dans votre diagramme de séquence"
          echo 'e - edit commentaires'
          echo "ec - Il m'est impossible de générer la couverture de test puisque vous avez un erreur de compilation"
          echo "e2 - Vous n'avez pas créé d'employé dans votre diagramme de séquence ou vous n'avez pas créer les deux instance employe1:Employe et employe2:Employe"
          echo "et - Excellent travail, vous avez replis adéquatement tout les critères" 
          echo "gc - Le code de votre comparateur est bon"
          echo "gcu - Le code de votre comparateur est bon mais il pourrait être simplifié"
          echo "ee - Employe.getEntete est manquant dans votre diagramme de séquence"
          echo "he - Vous n'avez pas utilisé le bon type d'association entre les comparateurs et la classe abstraite ou l'interface. L'association pour l'abstractioon est le suivant --|> ou ..|> pour une interface"
          echo "mvn - mvn test"
          echo "nd - Je ne peux pas vérifier vos diagrammes il ne sont pas visible dans votre fichier PDF"
          echo "nc - Rien a corriger vous n'avez pas fait le travail"
          echo "sb - sb:StringBugger est manquand dans votre diagramme de séquence"
          echo "co - Manque l'appel à la méthode compare sur les comparateur"
          echo "cc - L'association entre la Compagnie et Comparator ne doit pas être une composition"
          echo "c - continue to next student"
          echo "dep - Il ne devrait pas y avoir de dépendance entre les différent comparator et Employé.  Cela devrait etre représenté par une dépendance entre Interface Comparator et Employe"
          echo "x - exit"
          echo 'o - open all files'
          echo 's - sublime .'
          ;;
        s)
          sublime .
          ;;
        dep)
          echo "- Il ne devrait pas y avoir de dépendance entre les différent comparator et Employé.  Cela devrait etre représenté par une dépendance entre Interface Comparator et Employe"
          echo "- Il ne devrait pas y avoir de dépendance entre les différent comparator et Employé.  Cela devrait etre représenté par une dépendance entre Interface Comparator et Employe" >> correction-commentaires.txt  
          ;;
        ac)
        echo "L'association pour la crétion d'instance est de type -->"
        echo "L'association pour la crétion d'instance est de type -->" >> correction-commentaires.txt    
        ;;
        cc)
          echo "L'association entre la Compagnie et Comparator ne doit pas être une composition"
          echo "- L'association entre la Compagnie et Comparator ne doit pas être une composition" >> correction-commentaires.txt    
        ;;
        o)
          open README.pdf
          open README.md.pdf
          open correction-test.txt
          open ./src/main/java/PatronStrategie/Comparator/ComparatorNomSalaire.java
          ;;
        c)
          break
          ;;
        gc)
          echo "Le code de votre comparateur me semble bon"
          echo "- Le code de votre comparateur me semble bon" >> correction-commentaires.txt    
          ;;
        gcu)
          echo "Le code de votre comparateur est bon mais il pourrait être simplifié"
          echo "- Le code de votre comparateur est bon mais il pourrait être simplifié" >> correction-commentaires.txt    
          ;;
          
        e2)
          echo "Vous n'avez pas créé d'employé dans votre diagramme de séquence ou vous n'avez pas créer les deux instance employe1:Employe et employe2:Employe"
          echo "- Vous n'avez pas créé d'employé dans votre diagramme de séquence ou vous n'avez pas créer les deux instance employe1:Employe et employe2:Employe" >> correction-commentaires.txt    
          ;;
      
        nd)
          echo "Je ne peux pas vérifier vos diagrammes il ne sont pas visible dans votre fichier PDF"
          echo "- Je ne peux pas vérifier vos diagrammes il ne sont pas visible dans votre fichier PDF" >> correction-commentaires.txt    
          ;;

        co)
          echo "- Manque l'appel à la méthode compare sur les comparateurs"
          echo "- Manque l'appel à la méthode compare sur les comparateurs"  >> correction-commentaires.txt 
        ;;
        ec)
          echo "Il m'est impossible de générer la couverture de test puisque vous avez un erreur de compilation"
          echo "- Il m'est impossible de générer la couverture de test puisque vous avez un erreur de compilation" >> correction-commentaires.txt   
          ;;
        et)
          echo "Excellent travail, vous avez replis adéquatement tout les critères" 
          echo "- Excellent travail, vous avez replis adéquatement tout les critères" >> correction-commentaires.txt
          ;;
        e)
          sublime correction-commentaires.txt
        ;;
        bt)
          echo "Bon travail, vous avez remplis presque tout les critères" 
          echo "- Bon travail, vous avez remplis presque tout les critères" >> correction-commentaires.txt
          ;;
        he)
          echo "Vous n'avez pas utilisé le bon type d'association entre les comparateurs et la classe abstraite ou l'interface. L'association pour l'abstractioon est le suivant --|> ou ..|> pour une interface"
          echo "- Vous n'avez pas utilisé le bon type d'association entre les comparateurs et la classe abstraite ou l'interface. L'association pour l'abstractioon est le suivant --|> ou ..|> pour une interface"  >> correction-commentaires.txt
          ;;
        sb)
          echo "sb:StringBugger est manquand dans votre diagramme de séquence"
          echo "- sb:StringBugger est manquand dans votre diagramme de séquence" >> correction-commentaires.txt
          ;;
        ae)
          echo "ArrayList<Employe> est manquand dans votre diagramme de séquence"
          echo "- ArrayList<Employe> est manquand dans votre diagramme de séquence" >> correction-commentaires.txt
          ;;
        ee)
          echo "Employe.getEntete est manquant dans votre diagramme de séquence. getEntete est une opération statique sur la classe Employe"
          echo "- Employe.getEntete est manquant dans votre diagramme de séquence. getEntete est une opération statique sur la classe Employe" >> correction-commentaires.txt
          ;;
        cs)
          echo "Collection.sort(employes,ageComparator) est manquant dans votre diagramme de séquence. sort est une opération statique"
          echo "- Collection.sort(employes,ageComparator) est manquant dans votre diagramme de séquence. sort est une opération statique" >> correction-commentaires.txt
        ;;
        nc)
          echo "Rien a corriger vous n'avez pas fait le travail. Avisez moi si ce n'est pas le cas"
          echo "- Rien a corriger vous n'avez pas fait le travail. Avisez moi si ce n'est pas le cas" >> correction-commentaires.txt
          break
        ;;
        
        x)
        exit 0;
        ;;
        mvn)
          mvn test > correction-test.txt
          open correction-test.txt
          ;;
        *)
          echo "$commentaires" >> correction-commentaires.txt
          ;;
      esac
      
    done
  done
fi
