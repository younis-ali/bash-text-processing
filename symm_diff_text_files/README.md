# Symmetric Set Difference Bash Script

This bash script calculates the symmetric set difference between two text files, performs text transformations, and saves the result in an output file. It provides options to handle input files, output file, and text transformations.

## Usage

Run the script using the following command:

```bash
./symmetric_set_difference.sh -f file1.txt -s file2.txt -o output.txt
```

## Options
    -f file1.txt: Specify the first input file.
    -s file2.txt: Specify the second input file.
    -o output.txt: Specify the output file (optional, default is "output.txt").


## Script Explanation
The script performs the following steps:
1. Initialize Variables: Sets initial values for file1, file2, and output_file.
2. Parse Command Line Arguments: Uses getopts to parse command line arguments for input files and output file.
3. Check Required Arguments: Ensures that both input files are provided.
4. Transform Files to Lowercase: Uses tr command to transform files to lowercase and save the results in temporary files.
5. Ignore Punctuation: Removes punctuation from lowercase files using sed and saves the processed files.
6. Calculate Symmetric Set Difference: Uses comm and cat to find the symmetric set difference between processed files.
7. Replace Specific Patterns: Uses sed to replace specific patterns in the symmetric set difference.
8. Sort and Remove Duplicates: Uses sort and uniq to sort and remove duplicate lines from the transformed output.
9. Save to Output File: Saves the final result in the specified output file.

## Example
Suppose you have two input files: file1.txt and file2.txt. To calculate the symmetric set difference, transform the text to lowercase, ignore punctuation, and save the result in output.txt, you would run:
```
./symmetric_set_difference.sh -f file1.txt -s file2.txt -o output.txt
```
