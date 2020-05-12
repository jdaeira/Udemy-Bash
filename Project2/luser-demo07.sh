#!/bin/bash

# Demonstrate the use of shift and while loops

echo "Parameter 1: ${1}"
echo "Parameter 1: ${2}"
echo "Parameter 1: ${3}"
echo

# Loop through all the positional parameters
while [[ "${#}" -gt 0 ]]
do
  echo "Number of parameters: ${#}"
  echo "Parameter 1: ${1}"
  echo "Parameter 2: ${2}"
  echo "Parameter 3: ${3}"
  echo  
  shift
done