#!/bin/bash
# Programm für Youtube-DL zur einfachen benutzung zum Download
# für Video und Audio als auswahlmöglichkeit


# URL Eingabe
echo "Enter URL"
read url

# Format abfrage
youtube-dl -F $url > format

i=1

cut -d\  -f1 format | while read line
do
	echo "$i.) $line"
	i=`expr $i + 1`
done

# Auswahl treffen
echo "Einfacher Download (1) oder Auswahl von AV (2)"
read -n 1 antwort

if [ "$antwort" = "1" ]
then
	youtube-dl $url
fi

if [ "$antwort" = "2" ]
then 
	echo "Auswahl von Video und Audio"
	echo "Video Format"
	read -n 2 cut -d\  -f1 $line > video
	echo "Audio Format"
	read -n 2 cut -d\  -f1 $line > audio
	youtube-dl -f $video+$audio $url
fi
