
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 00:00:22 -to 00:01:42 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/01-intro.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 00:02:04 -to 00:13:00 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/02-presenter-et-applique-patron-gof.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 00:13:04 -to 00:14:19 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/03-GRASP-dans-le-GOFA.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 00:14:36 -to 00:30:15 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/03-GRASP-dans-le-GOFB.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 01:09:44 -to 01:20:07 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/04-adaptateur-fabrique-singleton.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 01:20:13 -to 01:39:20 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/05-logique-tarification-elaboree.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 01:39:24 -to 01:46:08 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/06-actualisation-IU-observateur.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 01:46:11 -to 01:52:29 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/07-attribut-qualite-recouvrement-adaptateur.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 01:52:32 -to 02:06:57 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/08-tolerance-aux-fautes-exception.mp4
ffmpeg -i /Volumes/LaCie/Yvan/ets-cours/seance-09/S20203-LOG210-C09-G04.mp4 -ss 02:18:34 -to 02:36:53 /Volumes/LaCie/Yvan/ets-cours/seance-09/out/09-attribut-qualite-recouvrement-proxy.mp4

ffmpeg -f concat  -safe 0 -i merge.txt -c copy  /Volumes/LaCie/Yvan/ets-cours/seance-09/out/03-GRASP-dans-le-GOF.mp4