ffmpeg -i zoom_0.mp4  -ss 00:08:00 -to 00:35:39 S20203-LOG210-c10-g01-affinement-mdd-zoom.mp4 
ffmpeg -i zoom_0.mp4  -ss 00:35:47  -to 01:05:25 S20203-LOG210-c10-g01-diagramme-activite-zoom.mp4 &&
ffmpeg -i zoom_0.mp4  -ss 01:36:44 -to 01:51:58 S20203-LOG210-c10-g01-exercice-communication-to-sequence-zoom.mp4 &&
ffmpeg -i zoom_0.mp4  -ss 01:51:59 -to 02:22:10 S20203-LOG210-c10-g01-diagramme-etat.mp4 &&
ffmpeg -i zoom_0.mp4  -ss 02:30:46 -to 02:53:20 S20203-LOG210-c10-g01-diagramme-etat.mp4 &&
ffmpeg -i zoom_0.mp4  -ss 02:30:46 -to 02:53:20 S20203-LOG210-c10-g01-diagramme-activite.mp4 



                    ffmpeg -i zoom_0.mp4   -ss 02:02:47 -to 02:52:47 volume.mp4 

ffmpeg -i volume.mp4 -filter:a "volume=0.5"  volume_3.mp4 

ffmpeg -i S20203-LOG210-c10-g01-affinement-mdd-zoom.mp4 -filter:a "volume=0.5" S20203-LOG210-c10-g01-affinement-mdd-zoom_05.mp4
ffmpeg -i S20203-LOG210-c10-g01-diagramme-activite-zoom.mp4 -filter:a "volume=0.5" S20203-LOG210-c10-g01-diagramme-activite-zoom_05.mp4
ffmpeg -i S20203-LOG210-c10-g01-exercice-communication-to-sequence-zoom.mp4 -filter:a "volume=0.5" S20203-LOG210-c10-g01-exercice-communication-to-sequence-zoom_05.mp4
ffmpeg -i S20203-LOG210-c10-g01-diagramme-etat.mp4 -filter:a "volume=0.5" S20203-LOG210-c10-g01-diagramme-etat_05.mp4
ffmpeg -i S20203-LOG210-c10-g01-diagramme-etat.mp4 -filter:a "volume=0.5" S20203-LOG210-c10-g01-diagramme-etat_05.mp4
ffmpeg -i S20203-LOG210-c10-g01-diagramme-activite.mp4 -filter:a "volume=0.5" S20203-LOG210-c10-g01-diagramme-activite_05.mp4

ffmpeg -i S20203-LOG210-c10-g01-affinement-mdd-zoom.mp4 -filter:a volumedetect -f null /dev/null

ffmpeg -i S20203-LOG210-c10-g01-affinement-mdd-zoom.mp4 -filter:a loudnorm S20203-LOG210-c10-g01-affinement-mdd-zoom-norm.mp4
ffmpeg -i input.flac -filter:a loudnorm output.flac