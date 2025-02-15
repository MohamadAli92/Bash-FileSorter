# Bash-FileSorter
File Sorting Automation Project

## Overview
This project is a file-sorting automation tool that organizes files into directories based on their type. It consists of two scripts: one for file creation and another for file sorting. The goal is to automate file management by categorizing files efficiently.

## Features
- **Automated file creation** with random types.
- **Sorting mechanism** that moves files into appropriate directories.
- **Error handling** for invalid inputs.

## Implementation Details

### 1. File Creation Script
- Creates files in a **specified directory**.
- Takes three parameters:
  1. **Directory**: Location where files are created.
  2. **Number of Files**: Total number of files to generate.
  3. **Number of Types**: Variety of file types to be created.
- Uses the `touch` command to generate files with random extensions.
- Implements `$RANDOM%$3` to assign file types randomly.

### 2. File Sorting Script
- Moves files into **folders based on their extensions**.
- Takes four parameters:
  1. **Input Directory**: Source directory containing unsorted files.
  2. **Output Directory**: Destination for sorted files.
  3. **Number of Files**: Total files to process.
  4. **Number of Types**: Variety of file types.
- Creates a separate folder for each file type in the output directory.
- Uses regex operations to sort and move files appropriately.
- Handles errors with proper validation and messages.

## Key Commands Used
- `touch`: Creates files or updates timestamps.
- `mv`: Moves or renames files.
- `mkdir`: Creates directories.
- `echo`: Displays messages and handles errors.

## Example Usage
1. Generate 100 files of 5 different types in `/home/user/files`:
   ```sh
   ./create_files.sh /home/user/files 100 5
   ```
2. Sort the generated files into `/home/user/sorted_files`:
   ```sh
   ./sort_files.sh /home/user/files /home/user/sorted_files 100 5
   ```

