#!/bin/bash

RAW_DIR=./data_pre
DST_DIR=./assets/data

PHOTOS=()

mkdir -p data_pre
mkdir -p assets/data

rm -f $DST_DIR/*

for file in $RAW_DIR/*
do
  echo "Processing [${file##*/}]..."
  convert "$RAW_DIR/${file##*/}" -gravity center -crop 1:1 -resize 512x512 "$DST_DIR/${file##*/}"
  PHOTOS+=("${file##*/}")
done

printf '%s\n' "${PHOTOS[@]}" | jq -R . | jq -s . > photos.json
echo "Finished!"