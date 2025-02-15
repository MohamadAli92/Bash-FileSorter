#!/usr/bin/env bash

output_directory=$1
input_directory=$2
files_n=$3
files_type_n=$4

if [[ $# -ne 4 ]]
then
    echo -e "\n\033[0;31m×××\033[0m Wrong number of parameters! \033[0;31m×××\033[0m"
    exit 1
fi

if [ ! -d "$output_directory" ]; then

    echo -e "\n\033[0;31m×××\033[0m Invalid output Directory: (\033[0;31m$output_directory\033[0m) in first parameter. \033[0;31m×××\033[0m"

    echo -e "\033[0;33m-->\033[0m Do you want to make directory? (Y/N)"

    confirm=''

    read -r -p '' confirm

    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then

        mkdir "$output_directory" > /dev/null 2>&1
        result=$?
        
        if [ $result -ne 0 ]; then

            echo -e "\n\033[0;31m×××\033[0m Directory didn't create. \033[0;31m×××\033[0m"
            exit 1
        
        else
            echo -e "\033[0;33m-->\033[0m \033[0;32mSuccessfully created directory.\033[0m \033[0;36m$output_directory\033[0m"
        fi

    else

        exit 1
        
    fi

fi

if [[ ! $files_n =~ ^[0-9]+$ || ! $files_type_n =~ ^[0-9]+$ || $files_n == 0 || $files_type_n == 0 ]]; then
    echo -e "\n\033[0;31m×××\033[0m Invalid Number of files:(\033[0;31m$files_n\033[0m) or types:(\033[0;31m$files_type_n\033[0m) in third or fourth parameter. \033[0;31m×××\033[0m"
    exit 1
fi

if [ "${input_directory[*]: -1: 1}" != "/" ]; then
    input_directory="$input_directory""/"
fi

if [ "${output_directory[*]: -1: 1}" != "/" ]; then
    output_directory="$output_directory""/"
fi

./pt1.sh "$input_directory" "$files_n" "$files_type_n"

pt1_result=$?

echo

if [ "$pt1_result" -eq 1 ]; then
    echo -e "\n\033[0;33m-->\033[0m Script1 didn't complete successfully."
    echo -e "\n\033[0;33m-->\033[0m Closing script..."
    exit 1
fi

files_count=0

for name in "$input_directory"*.*; do

    file_ext="${name##*.}"

    if [ "$file_ext" != "sh" ]; then

            files_count=$((files_count + 1))

            if [ ! -d "$output_directory""$file_ext" ]; then
                mkdir "$output_directory""$file_ext"
                echo -e "\033[0;33m-->\033[0m Successfully generated folder: \033[0;36m$output_directory$file_ext\033[0m"
            fi

    fi

done

echo -e "\n\033[0;33m-->\033[0m Moving files to folders..."

for((i=0;i<files_count;i++)); do
    printf "⬜"
done

counter=0

printf "\r"

for file_path in "$input_directory"*.*; do
    
    sleep 0.1s

    file_ext="${file_path##*.}"

    if [ "$file_ext" != "sh" ]; then
        mv "$file_path" "$output_directory""$file_ext" > /dev/null 2>&1
        counter=$((counter + 1))
        for((i=0;i<counter;i++)); do
            printf "🟩\b"
        done
    fi

    printf "\r"

done

printf "\n\n\033[0;42mSuccessfully completed Script2.\033[0m\n"

exit 0
