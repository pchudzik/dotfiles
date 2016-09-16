#!/bin/bash

# requires curl and jq (https://stedolan.github.io/jq/)
# usage ./xkpasswd.sh numberOfPasswords||5

function xkpasswd() {
  SETTINGS=`cat << EOF
  {
   "num_words": 6,
   "word_length_min": 6,
   "word_length_max": 10,
   "case_transform": "RANDOM",
   "separator_character": "RANDOM",
   "separator_alphabet": [
    "!",
    "@",
    "$",
    "%",
    "^",
    "&",
    "*",
    "-",
    "_",
    "+",
    "=",
    ":",
    "|",
    "~",
    "?",
    "/",
    ".",
    ";"
   ],
   "padding_digits_before": 2,
   "padding_digits_after": 2,
   "padding_type": "FIXED",
   "padding_character": "RANDOM",
   "symbol_alphabet": [
    "!",
    "@",
    "$",
    "%",
    "^",
    "&",
    "*",
    "-",
    "_",
    "+",
    "=",
    ":",
    "|",
    "~",
    "?",
    "/",
    ".",
    ";"
   ],
   "padding_characters_before": 2,
   "padding_characters_after": 2,
   "random_increment": "AUTO"
  }
EOF`

  COUNT=$1
  ACTION="genpw"

  if [ -z $COUNT ]; then
  	COUNT=5
  fi

  curl -s -X POST \
       --data-urlencode "a=$ACTION" \
       --data-urlencode "n=$COUNT" \
       --data-urlencode "c=$SETTINGS" "https://xkpasswd.net/s/index.cgi" | \
       jq -r '.passwords|join("\n")'
}