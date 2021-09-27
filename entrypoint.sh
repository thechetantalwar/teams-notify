#!/bin/bash
text='{"text":"'${2}'"}'
echo $text > test.txt
curl $1 -X POST -H 'Content-type: application/json' --data "@test.txt" 
