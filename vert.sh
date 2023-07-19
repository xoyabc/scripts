#!/bin/bash

FILE=$1

exp=$(cat ${FILE} |sed '/^\s*$/d' |tr '\n' '|' |sed 's#.$##g' )

echo " |grep -Ew \"${exp}\""
