#!/bin/bash
# Programm für Youtube-DL zur einfachen benutzung zum Download
# für Video und Audio als auswahlmöglichkeit

# Auswahl für zusätzliche Optionen sowie Download
PS3='Bitte auswahl treffen: '
options=("Show Extractors" "ignore Config" "Set Filename" "Activate quiet mode" "Verbose Mode" "Display traffic" "Extract Audio" "Start Download" "Ende")
select opt in "${options[@]}"
do
	case $opt in
		"Show Extractors")
			youtube-dl --list-extractors > extractors
			cat extractors
			;;

		"ignore Config")
			iconfig=--ignore-config
			;;

		"Set Filename")
			echo "Dateiname Eingeben: "
			read setfile
			;;

		"Activate quite mode")
			quite=--quite
			;;

		"Verbose Mode")
			verbose=--verbose
			;;

		"Display traffic")
			traffic=--print-traffic
			;;

		"Extract Audio")
			echo "Specify audio format: best, aac, flac, mp3, m4a, opus, vorbis, or wav"
			read aformat
			eaudio=--extract-audio
			audioo=--audio-format
			;;

		"Start Download")
			# URL Eingabe
			echo "Enter URL"
			read url			
			
			# Direkt Downloaden oder Auswählen
			PS3='Bitte auswahl treffen: '
			auswahl=("Direkter Download" "Download mit Option" "Audio Only" "Video/Audio" "Video/Audio best" "Ende")
			select aopt in "${auswahl[@]}"
			do
				case $aopt in
					"Direkter Download")
					youtube-dl $url
					;;
					
					"Download mit Optionen")
					youtube-dl $iconfig $setfile $quite $verbose $traffic $url
					;;
					
					"Audio Only")
					youtube-dl $eaudio $audioo $aformat $url
					;;
			
					"Video/Audio")
					# Format abfrage
					youtube-dl -F $url > format

					i=1

					cat format

#					cut -d\  -f1 format | while read line
#					do
#						echo "$i.) $line"
#						i=`expr $i + 1`
#					done
					
					echo "Video"
					read video
					echo "Audio"
					read audio
					echo $video+$audio
					youtube-dl -f $video+$audio $url
					;;
					
					"Video/Audio best")
					youtube-dl -f best $url
					;;
					
					"Ende")
						break
						;;
						
					*) echo "Ungültige auswahl $REPLY";;
				esac
			done
			;;
			
		"Ende")
			break
			;;
			
		*) echo "Ungültige auswahl $REPLY";;
	esac
done
