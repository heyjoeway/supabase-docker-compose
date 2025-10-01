#!/bin/bash

# Get the date parameter or use today's date if not provided
if [ -z "$1" ]; then
    checkpoint_date=$(date +%Y-%m-%d)
else
    checkpoint_date=$1
fi

# Create the checkpoint directory
checkpoint_dir="_checkpoints/$checkpoint_date"
if [ -d "$checkpoint_dir" ]; then
    rm -rf "$checkpoint_dir"
fi
mkdir -p "$checkpoint_dir"

# Copy all files and directories except .git and .gitignore, but include .env files
rsync -av --exclude='.git' --exclude='.gitignore' --exclude='create_checkpoint.sh' --exclude='run.sh' --exclude='_checkpoints' --exclude='screenshots' ./ "$checkpoint_dir/"

# Explicitly copy .env files (rsync excludes hidden files by default in some cases)
find . -maxdepth 1 -name ".env*" -type f -exec cp {} "$checkpoint_dir/" \;

echo "Checkpoint created at $checkpoint_dir"
