#!/bin/bash

# Define the changelog filename and location
CHANGELOG_FILE="./changelog.md"

# Get the commit message
COMMIT_MSG=$(git log -1 --pretty=%B)

# Define the emoji mapping for the commit types
declare -A EMOJI_MAP=(
    ["feat"]=":sparkles:"
    ["fix"]=":bug:"
    ["docs"]=":books:"
    ["style"]=":lipstick:"
    ["refactor"]=":hammer:"
    ["test"]=":rotating_light:"
    ["chore"]=":wrench:"
)

# Parse the commit message and extract the commit type and message
IFS=' ' read -ra MSG_PARTS <<< "$COMMIT_MSG"
COMMIT_TYPE=${MSG_PARTS[0]}
COMMIT_MSG=${MSG_PARTS[@]:1}

# Get the emoji for the commit type from the emoji mapping
EMOJI=${EMOJI_MAP[$COMMIT_TYPE]}

# Check if the changelog file exists
if [ ! -f "$CHANGELOG_FILE" ]; then
    # If the changelog file does not exist, create it and add a heading
    touch "$CHANGELOG_FILE"
    echo "# Changelog" > "$CHANGELOG_FILE"
fi

# Add the changelog entry for the commit
echo "$EMOJI $COMMIT_MSG" >> "$CHANGELOG_FILE"