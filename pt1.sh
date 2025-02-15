#!/usr/bin/env bash


directory=$1
files_n=$2
files_type_n=$3

if [[ $# -ne 3 ]]
then
    echo -e "\n\033[0;31m×××\033[0m Wrong number of parameters! \033[0;31m×××\033[0m"
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo -e "\n\033[0;31m×××\033[0m Invalid input Directory: (\033[0;31m$directory\033[0m) in first parameter. \033[0;31m×××\033[0m"

    echo -e "\033[0;33m-->\033[0m Do you want to make directory? (Y/N)"

    confirm=''

    read -r -p '' confirm

    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then

        mkdir "$directory" > /dev/null 2>&1
        result=$?
        
        if [ $result -ne 0 ]; then

            echo -e "\n\033[0;31m×××\033[0m Directory didn't create. \033[0;31m×××\033[0m"
            exit 1
        
        else
            echo -e "\033[0;33m-->\033[0m \033[0;32mSuccessfully created directory.\033[0m \033[0;36m$directory\033[0m"
        fi

    else

        exit 1
        
    fi

else

    echo -e "\n\033[0;33m-->\033[0m Input Directory exists, Do you want to remove it? (Y/N)"

    confirm=''

    read -r -p '' confirm

    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then

        rm -r "$directory" > /dev/null 2>&1
        result_rm=$?

        mkdir "$directory" > /dev/null 2>&1
        result_mk=$?
        
        if [ $result_rm -ne 0 ] && [ $result_mk -ne 0 ]; then

            echo -e "\n\033[0;31m×××\033[0m Directory didn't remove and new directory didn't create. \033[0;31m×××\033[0m"
            exit 1
        
        elif [ $result_mk -ne 0 ]; then

            echo -e "\n\033[0;31m×××\033[0m New directory didn't create. \033[0;31m×××\033[0m"

        elif [ $result_rm -ne 0 ]; then

            echo -e "\n\033[0;31m×××\033[0m Directory didn't remove. \033[0;31m×××\033[0m"

        else
            echo -e "\033[0;33m-->\033[0m \033[0;32mSuccessfully removed directory and creted a new one.\033[0m \033[0;36m$directory\033[0m"
        fi

    elif [[ $confirm == [nN] || $confirm == [nN][oO] ]]; then

        echo -e "\033[0;33m-->\033[0m \033[0;32mAdding files to previous directory.\033[0m \033[0;36m$directory\033[0m"

    else

        exit 1

    fi


fi

if [ "${directory[*]: -1: 1}" != "/" ]; then
    directory="$directory""/"
fi


if [[ ! $files_n =~ ^[0-9]+$ || ! $files_type_n =~ ^[0-9]+$ || $files_n == 0 || $files_type_n == 0 ]]; then
    echo -e "\n\033[0;31m×××\033[0m Invalid Number of files:(\033[0;31m$files_n\033[0m) or types:(\033[0;31m$files_type_n\033[0m) in second or third parameter. \033[0;31m×××\033[0m"
    exit 1
fi

printf "\n\033[0;33mStarting script1 ...\033[0m\n"

printf '\n\033[0;33m-->\033[0m Creating %s files with random extensions among %s file types in: \033[0;36m%s\033[0m' "$files_n" "$files_type_n" "$directory"

declare -A newArr

while [ ${#newArr[@]} -lt "$files_type_n" ]
do

    a=()
    for b in {a..z} {0..9}; do
        a[RANDOM]=$b
    done
    
    str_a=$(echo "${a[*]::3}" | tr -d ' ')

    newArr[$str_a]=":)"
    
done

file_types_arr=()

for i in "${!newArr[@]}"; do
    file_types_arr+=("$i")
done

echo -e "\n\033[0;33m-->\033[0m Generated extensions are: \033[0;36m$(echo "${file_types_arr[*]}" | tr -s ' ' '|')\033[0m"

for((i=0;i<files_n;i++)); do

    ext=${file_types_arr[$RANDOM%$files_type_n]}
    file_path_name="${directory}file_$i.$ext"

    while test -f "$file_path_name";
    do
        ext=${file_types_arr[$RANDOM%$files_type_n]}
        file_path_name="${directory}file_$i.$ext"
    done
    
    touch "$file_path_name"

    echo -e "\033[0;33m-->\033[0m Successfully generated file: \033[0;36m$file_path_name\033[0m"

done

printf "\n\033[0;42mSuccessfully completed Script1.\033[0m\n"

exit 0
