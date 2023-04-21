#!/bin/bash

# # Print the script name
# echo "Script name: $0"
# # Print the number of arguments
# echo "Number of arguments: $#"
# # Print each argument using positional parameters
# for i in "$@"
# do
#     echo "Argument: $i"
# done

# Get the script's directory
script_dir=$(dirname "$(realpath "$0")")

# Step 1: Pass in the arguments
path=$1
name=$2
description=$3

# Step 2: Call ipfs add with the provided file path
output=$(ipfs add "$path")

# Step 3: Get the file hash from the ipfs add call
file_hash=$(echo "$output" | awk '{print $2}')

# Step 4: Create a JSON file with the metadata
metadata_file="$script_dir/../credentials/metadata/metadata_$file_hash.json"

cat << EOF > "$metadata_file"
{
    "name": "$name",
    "description": "$description",
    "file": "https://ipfs.io/ipfs/$file_hash"
}
EOF

# Step 5: Add the JSON file to IPFS
metadata_output=$(ipfs add "$metadata_file")

# Step 6: Get the file hash of the metadata JSON file and return it to stdout
metadata_file_hash="https://ipfs.io/ipfs/$(echo "$metadata_output" | awk '{print $2}')"
echo "$metadata_file_hash"
