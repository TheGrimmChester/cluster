#!/bin/bash

find ./kubernetes/apps/ -name ".sops.yaml" -type f -print0 | while IFS= read -r -d '' file; do
    echo "Processing file: $file"
    dir=$(dirname "$file")
    filename=$(basename "$file")
    dest="${dir}/secrets.sops.yaml"
    command="/usr/local/bin/sops --config .sops.yaml --encrypt ${file} > ${dest}"

    eval $command
    echo $dest
done
