#!/bin/bash

# https://unix.stackexchange.com/questions/86875/determining-specific-file-responsible-for-high-i-o

####
# Creates files underneath /tmp
# Requires commands: timeout  strace  stty
####
#
# All commands are GNU unless otherwise stated
#
##########################################################


####
## Initialization
####

outputFile=/tmp/out.$RANDOM.$$
uniqueLinesFile=/tmp/unique.$RANDOM.$$
finalResults=/tmp/finalOutput.txt.$$

if [ $# -ne 1 ]; then
    echo "USAGE: traceIO [PID]" >&2
    exit 2
fi

if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "USAGE: traceIO [PID]" >&2
    echo -e "\nGiven Process ID is not a number." >&2
    exit 2
fi

if [ ! -e /proc/$1 ]; then
    echo "USAGE: traceIO [PID]" >&2
    echo -e "\nThere is no process with $1 as the PID." >&2
    exit 2
fi

if [[ "x$PAGER" == "x" ]]; then

   for currentNeedle in less more cat; do

      which $currentNeedle >/dev/null 2>&1

      if [ $? -eq 0 ]; then
         PAGER=$currentNeedle
         break;
      fi

   done

  if [[ "x$PAGER" == "x" ]]; then

     echo "Please set \$PAGER appropriately and re-run" >&2
     exit 1

  fi

fi

####
## Tracing
####

echo "Tracing command for 30 seconds..."

timeout 30 strace -e trace=file -fvv -p $1 2>&1 | egrep -v -e "detached$" -e "interrupt to quit$" | cut -f2 -d \" > $outputFile

if [ $? -ne 0 ]; then
   echo -e "\nError performing Trace. Exiting"
   rm -f $outputFile 2>/dev/null
   exit 1
fi

echo "Trace complete. Preparing Results..."

####
## Processing
####

sort $outputFile | uniq > $uniqueLinesFile

echo -e "\n--------  RESULTS --------\n\n  #\t Path " > $finalResults
echo -e " ---\t-------" >> $finalResults

while IFS= read -r currentLine; do

   echo -n $(grep -c "$currentLine" "$outputFile")
   echo -e "\t$currentLine"

done < "$uniqueLinesFile" | sort -rn >> $finalResults

####
## Presentation
####

resultSize=$(wc -l $finalResults | awk '{print $1}')
currentWindowSize=$(stty size | awk '{print $1}')

  # We put five literal lines in the file so if we don't have more than that, there were no results
if [ $resultSize -eq 5 ]; then

   echo -e "\n\n No Results found!"

elif [ $resultSize -ge $currentWindowSize ] ; then

   $PAGER $finalResults

else

   cat $finalResults

fi

  # Cleanup
rm -f $uniqueLinesFile $outputFile $finalResults
