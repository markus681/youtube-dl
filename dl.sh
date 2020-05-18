#!/bin/bash
# Programm für Youtube-DL zur einfachen benutzung zum Download
# für Video und Audio als auswahlmöglichkeit

# URL Eingabe
echo "Enter URL"
read url

# Format abfrage
youtube-dl -F $url > format

cat format

# Auswahl treffen
echo "Einfacher Download (1), Auswahl von AV (2), -f best Download (3)"
read -n 1 antwort

if [ "$antwort" = "1" ]
then
        youtube-dl $url
fi

if [ "$antwort" = "2" ]
then 
        echo "Auswahl von Video und Audio"
        echo "Video Format"
        read video
        echo "Audio Format"
        read audio
        youtube-dl -f $video+$audio $url
fi

if [ "$antwort" = "3" ]
then
        youtube-dl -f best $url
fi
