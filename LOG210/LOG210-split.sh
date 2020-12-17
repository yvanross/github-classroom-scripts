
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 00:00:06 -to 00:01:43 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/01-introduction-equipe.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 00:02:59 -to 00:10:47 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/02-profil-personnel-yvan.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 00:15:16 -to 00:29:13 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/03-meilleures-pratiques-pour-apprendre.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 00:29:13 -to 00:31:09 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/03-notes-de-cours-et-livre-obligatoire .mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 00:31:12 -to 00:39:13 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/04-survol-technologies.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 00:39:16  -to 00:59:49 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/05-introduction-analyse-conception.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 01:01:54 -to 01:05:06 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/06-Outil-de-travail.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 01:05:44 -to 01:14:53 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/07-plan-de-cours.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 01:19:23  -to 01:20:13 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/08-github-classroom-faire-demo.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 01:22:53 -to 01:48:36 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/09-developpement-logiciel-en-equipe.mp4 
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 01:48:38 -to 01:53:55 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/10-processus-unifie.mp4
#ffmpeg -i '/Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/S20203 LOG210 C01 G03 zoom 0_out.mp4' -ss 02:18:34 -to 02:36:53 /Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/11-attribut-qualite-recouvrement-proxy.mp4


#ffmpeg -f concat  -safe 0 -i merge.txt -c copy  Volumes/LaCie/Yvan/ets-cours/S20211-LOG210-C01/03-GRASP-dans-le-GOF.mp4


' split files
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G03 zoom 0.mp4' -ss 00:45:42 -to 00:46:10  ./temp/temp01.mp4
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G03 zoom 0.mp4' -ss 00:46:20 -to 00:47:08  ./temp/temp02.mp4
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G03 zoom 0.mp4' -ss 00:47:43 -to 00:47:51  ./temp/temp03.mp4
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G03 zoom 0.mp4' -ss 00:47:55 -to 00:54:39  ./temp/temp04.mp4
echo "file 'temp01.mp4'" > ./temp/combine.txt
echo "file 'temp02.mp4'" >> ./temp/combine.txt
echo "file 'temp03.mp4'" >> ./temp/combine.txt
echo "file 'temp04.mp4'" >> ./temp/combine.txt
ffmpeg -hide_banner -stats -f concat -safe 0 -i ./temp/combine.txt  LOG210-C01-AC00-02-survol.mp4
rm temp0*.mp4

ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G03 zoom 0.mp4' -ss 00:54:46 -to 01:16:12  ./temp/LOG210-C01-AC00-02-analyse-et-conception-oriente-objet.mp4


ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G02 zoom 0.mp4' -ss 02:28:55 -to 02:32:12  ./temp/LOG210-C01-AC00-05-dcu.mp4
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G02 zoom 0.mp4' -ss 02:32:13 -to 02:33:57  ./temp/LOG210-C01-AC00-06-cu.mp4
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G02 zoom 0.mp4' -ss 02:33:58 -to 02:41:20  ./temp/LOG210-C01-AC00-06-iu.mp4
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G02 zoom 0.mp4' -ss 02:41:20 -to 02:54:27  ./temp/LOG210-C01-AC00-06-mdd.mp4
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G02 zoom 0.mp4' -ss 02:54:28 -to 03:03:16  ./temp/LOG210-C01-AC00-06-dss.mp4
ffmpeg -i '/Users/rossypro/Downloads/video/S20203 LOG210 C01 G02 zoom 0.mp4' -ss 03:03:16 -to 03:13:25  ./temp/LOG210-C01-AC00-06-contrat.mp4




  