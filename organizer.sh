#!/bin/bash

read -p "Please enter the directory path: " dir_path

if [ ! -d "$dir_path" ] ;then
	echo "Error.. The "$dir_path" directory does not exist"
	exit 1
fi

echo "Directory found! Proceeding to organize..."

mkdir -p "$dir_path/Images"
mkdir -p "$dir_path/Documents"
mkdir -p "$dir_path/Videos"
mkdir -p "$dir_path/Archives"

for file in "$dir_path"/*;
do
	if [ -f "$file" ]; then

		filename=$(basename "$file")
		if [[ "$filename" == *.jpg ]] || [[ "$filename" == *.jpeg ]] || [[ "$filename" == *.png ]] || [[ "$filename" == *.gif ]] ; then
			dest_folder="Images"

		elif [[ "$filename" == *.pdf ]] || [[ "$filename" == *.doc ]] ||[[ "$filename" == *.docx ]] || [[ "$filename" == *.txt ]] ; then
			dest_folder="Documents"

		elif [[ "$filename" == *.mp4 ]] || [[ "$filename" == *.mkv ]] ||[[ "$filename" == *.avi ]] ; then
			dest_folder="Videos"

		elif [[ "$filename" == *.zip ]] || [[ "$filename" == *.rar ]] ||[[ "$filename" == *.tar.gz ]] ; then
			dest_folder="Archives"

		else 
			dest_folder="Others"
			mkdir -p "$dir_path/$dest_folder"
		fi

		final_name="$filename"
       	 	while [ -e "$dir_path/$dest_folder/$final_name" ]; do
            		echo "Warning: A file named '$final_name' already exists in $dest_folder."
            		read -p "Please enter a new name for this file (including extension): " final_name
        	done

		mv "$file" "$dir_path/$dest_folder/$final_name"
	        echo "Moved: $filename -> $dest_folder/$final_name"
	fi
done
