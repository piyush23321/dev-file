#!/bin/bash

# Define the changelog filename and location
CHANGELOG_FILE="./changelog.md"

# Get the commit message
COMMIT_MSG=$(git log -1 --pretty=%B)

# Get the current date and user who made the commit
CURRENT_DATE=$(date +%Y-%m-%d)
CURRENT_USER=$(git config user.name)

# Check the commit message for keywords and add an emoji based on the keyword
if [[ "$COMMIT_MESSAGE" == *add* ]]; then
  EMOJI=":rocket:"
elif [[ "$COMMIT_MESSAGE" == *fix* ]]; then
  EMOJI=":bug:"
elif [[ "$COMMIT_MESSAGE" == *upd* ]]; then
  EMOJI=":boom:"
else
  EMOJI="🤖"
fi



# Check if the changelog file exists
if [ ! -f "$CHANGELOG_FILE" ]; then
    # If the changelog file does not exist, create it and add a heading
    touch "$CHANGELOG_FILE"
    echo "# Changelog" > "$CHANGELOG_FILE"
fi

# Add the changelog entry for the commit
echo "- $EMOJI $COMMIT_MESSAGE ($CURRENT_DATE, $CURRENT_USER)" >> "$CHANGELOG_FILE"

# For reset last commit
# git reset --hard HEAD~1

# Add all files to the Git staging area
git add .

# Create the commit with the given message
git commit -m "$COMMIT_MSG"
