#!/bin/bash

# pptx to markdown converter
# Revan Sopher 2014
# Creates folder pptimages and md file with unformatted text and images
# TODO don't destroy formatting

if [ $# -ne 1 ]; then
  echo "Usage $0 <file.pptx>"
  exit 1
fi


for file in $(ls $1/*.pptx); do
  echo "filename = " $file

  temp="/tmp/pptx2md"
  output="$(basename $file).md"
  output1="$temp/$(basename $file)1.md"
  output2="$temp/$(basename $file)2.md"
  output3="$temp/$(basename $file)3.md"

  media="../media/$(basename $file)"
  # media= "/Users/rossypro/GDrive/cc-yvan.ross@etsmtl.net/LOG210 Collaboration enseignants/S20201/media/$(basename $1)"

  #extract file
  unzip -oq -d $temp $file
  if [ $? -ne 0 ]; then
    echo "Failed to extract."
    exit 1
  fi

  echo "---
  theme : "beige"
  transition: "slide"
  highlightTheme: "monokai"
  logoImg: "logo.png"
  slideNumber: true
  title: "Allo mon coco"
  " > $output1

  #replace <> with \n, images with placeholder, strip style.visibility
  for filename in $(ls $temp/ppt/slides/*.xml | sort --version-sort -f); do
    xsltproc ../ppt2md/xml2md.xsl $filename >> $output1
  done

  cat $output1 | sed -e 's/\&gt;/</g' -e 's/\&lt;/>/g' -e 's/\&amp;gt;/</g' -e 's/\&amp;lt;/>/g' -e 's/\<?xml version=\"1.0\"?\>//g' > $output2

  #next, we replace placeholder text with an incrementing image link
  imageNum=1
  while read line; do
    if echo "$line" | grep -q "!\[Picture "; then
      echo "$line" >> $output3
      echo "![image](../media/$(basename $file)/image${imageNum}.jpeg)" >> $output3
      imageNum=$((imageNum+1))
    else
      echo "$line" >> $output3
    fi
  done < $output2

  #copy images files
  mkdir -p $media
  cp -rf ${temp}/ppt/media/ $media

  for image in $(ls $media/*.*); do
    name=$(basename -- "$image")
    extension="${name##*.}"
    file_name="${name%.*}"
    sed -ie "s/$file_name.jpeg/$file_name.$extension/g"  $output3
  done

  # copy output file and cleanup
  cp $output3 $output
  rm $output1
  rm $output2
  rm $output3
  rm -rf /tmp/pptx2md

done

