#!/bin/sh

# Load variables from .env file.
while IFS== read -r key value; do
  if [ ! -z "$key" ] && [[ ! $key == \#* ]]; then
    fmtValue="${value//\"/}";
    printf -v "$key" %s "$fmtValue" && export "$key"
  fi
done <.env

# Make sure the Manifest file exists so it can be added to the TOC. 
touch $NAME_OF_TOC_FILE;

# Create the Table of Contents
./maketoc.sh > $NAME_OF_TOC_FILE;

# Run the Archive Tool
wine "$PATH_TO_ARCHIVE_TOOL" -a ".\\$NAME_OF_BIG_FILE" -r "." -c ".\\$NAME_OF_TOC_FILE";
