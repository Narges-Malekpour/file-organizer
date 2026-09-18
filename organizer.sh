#!/bin/bash

read -p "Please enter the directory path: " dir_path

if [ ! -d "$dir_path" ]; then
    echo "Error.. The '$dir_path' directory does not exist"
    exit 1
fi

echo "Directory found! Proceeding to organize..."

mkdir -p "$dir_path/Images"
mkdir -p "$dir_path/Documents"
mkdir -p "$dir_path/Videos"
mkdir -p "$dir_path/Archives"

count_images=0
count_docs=0
count_videos=0
count_archives=0
count_others=0

date >> "$dir_path/log.txt"

for file in "$dir_path"/*; do
    if [ -f "$file" ]; then
        
        filename=$(basename "$file")
        
        if [[ "$filename" != "log.txt" ]]; then

            if [[ "$filename" == *.jpg ]] || [[ "$filename" == *.jpeg ]] || [[ "$filename" == *.png ]] || [[ "$filename" == *.gif ]]; then
                dest_folder="Images"
                count_images=$((count_images + 1))

            elif [[ "$filename" == *.pdf ]] || [[ "$filename" == *.doc ]] || [[ "$filename" == *.docx ]] || [[ "$filename" == *.txt ]]; then
                dest_folder="Documents"
                count_docs=$((count_docs + 1))

            elif [[ "$filename" == *.mp4 ]] || [[ "$filename" == *.mkv ]] || [[ "$filename" == *.avi ]]; then
                dest_folder="Videos"
                count_videos=$((count_videos + 1))

            elif [[ "$filename" == *.zip ]] || [[ "$filename" == *.rar ]] || [[ "$filename" == *.tar.gz ]]; then
                dest_folder="Archives"
                count_archives=$((count_archives + 1))

            else
                dest_folder="Others"
                mkdir -p "$dir_path/$dest_folder"
                count_others=$((count_others + 1))
            fi

            final_name="$filename"
            while [ -e "$dir_path/$dest_folder/$final_name" ]; do
                read -p "File $final_name exists! enter new name: " final_name
            done

            mv "$file" "$dir_path/$dest_folder/$final_name"
            
            echo "Moved: $filename -> $dest_folder/$final_name"
            echo "$filename -> $dest_folder/$final_name" >> "$dir_path/log.txt"
            
        fi
    fi
done

echo "Images: $count_images"
echo "Documents: $count_docs"
echo "Videos: $count_videos"
echo "Archives: $count_archives"
echo "Others: $count_others"
