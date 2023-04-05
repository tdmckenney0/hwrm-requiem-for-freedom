#!/bin/sh

cat << HEADER
Archive name="Data"
TOCStart name="DataData" alias="Data" relativeroot=""
FileSettingsStart defcompression="1"
  Override wildcard="*.*" minsize="-1" maxsize="100" ct="0"
  Override wildcard="*.mp3" minsize="-1" maxsize="-1" ct="0"
  Override wildcard="*.wav" minsize="-1" maxsize="-1" ct="0"
  Override wildcard="*.jpg" minsize="-1" maxsize="-1" ct="0"
  Override wildcard="*.fda" minsize="-1" maxsize="-1" ct="0"
  Override wildcard="*.lua" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.txt" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.ship" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.resource" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.pebble" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.level" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.wepn" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.subs" minsize="-1" maxsize="-1" ct="2" 
  Override wildcard="*.miss" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.events" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.madstate" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.script" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.ti" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.st" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.vp" minsize="-1" maxsize="-1" ct="2"
  Override wildcard="*.wf" minsize="-1" maxsize="-1" ct="2"
  SkipFile wildcard="*emptyfile.txt" minsize="-1" maxsize="-1"
  SkipFile wildcard="*.avi" minsize="-1" maxsize="-1"
  SkipFile wildcard="*.webm" minsize="-1" maxsize="-1"
  SkipFile wildcard="*.big" minsize="-1" maxsize="-1"
  SkipFile wildcard="*.psd" minsize="-1" maxsize="-1" 
  SkipFile wildcard="*.sh" minsize="-1" maxsize="-1" 
  SkipFile wildcard="*.sfap0" minsize="-1" maxsize="-1"
FileSettingsEnd
HEADER

# Find all files in the directory and its subdirectories; exclude hidden files and directories.
FILES=$(find -not -path '*/[@.]*' -not -path "*.big" -not -path "*.webm" -not -path "*.psd" -not -path "*.sh" -type f);

# Loop through the files and convert to windows paths for the Archive
for FILE in $FILES
do
  echo "$FILE" | sed -e 's#^./##' -e 's#/#\\#g'
done

echo "TOCEnd";
