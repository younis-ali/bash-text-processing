#! /usr/bin/bash

# Initialize variables
file1=""
file2=""
output_file="output.txt"

# Parse the arguments 
: ' 
  getopts command parse the command line arguments.
    When -f is encountered, the argument following it is assigned to the file1 variable.
    When -s is encountered, the argument following it is assigned to the file2 variable.
    When -o is encountered, the argument following it is assigned to the output_file
    The while loop iterates over each option and its argument, and the case statement handles each option
'

while getopts "f:s:o:" opt; do
  case $opt in
    f) file1="$OPTARG";;
    s) file2="$OPTARG";;
    o) output_file="$OPTARG";;
    \?) echo "Usage: $0 -f file1.txt -s file2.txt [-o output.txt]"; exit 1;;
  esac
done

# Check if required arguments are provided 
if [[ -z "$file1" || -z "$file2" ]]; then
  echo "Both input files are required."
  echo "Usage: $0 -f file1.txt -s file2.txt [-o output.txt]"
  exit 1
fi

# Transform files to lowercase using TR command and then redirect the transformed contents to temporary files
tr '[:upper:]' '[:lower:]' < "$file1" > file1_lowercase.txt
tr '[:upper:]' '[:lower:]' < "$file2" > file2_lowercase.txt

# Ignore Punctuation during comparison
sed 's/[[:punct:]]//g' file1_lowercase.txt > file1_processed.txt
sed 's/[[:punct:]]//g' file2_lowercase.txt > file2_processed.txt

# Find the symmetric set difference using comm and grep
: ' 
  comm -23 <(sort file1_processed.txt) <(sort file2_processed.txt): 
    This command compares two sorted files line by line and produces three columns of output:
    Column 1: Lines unique to the first file (file1_processed.txt).
    Column 2: Lines unique to the second file (file2_processed.txt).
    Column 3: Lines common to both files.
    The options -23 suppress columns 1 and 2, leaving only the lines common to both files, which is the set intersection.
  
  comm -13 <(sort file1_processed.txt) <(sort file2_processed.txt): 
    This command also compares two sorted files line by line and produces three columns of output:
    Column 1: Lines unique to the first file.
    Column 2: Lines unique to the second file.
    Column 3: Lines common to both files.
    The options -13 suppress columns 1 and 3, leaving only the lines unique to the first file (set difference).
'
symmetric_set_difference=$(comm -23 <(sort file1_processed.txt) <(sort file2_processed.txt) | cat - <(comm -13 <(sort file1_processed.txt) <(sort file2_processed.txt)))

# Clean up temporary lowercase files
rm -f file1_lowercase.txt file2_lowercase.txt file1_processed.txt file2_processed.txt

# Sort and remove duplicates using sort and uniq
final_output=$(echo "$symmetric_set_difference" | sort | uniq)

# Save the final result to the output file
echo "$final_output" > "$output_file"

echo "Symmetric Set Difference saved to $output_file"
