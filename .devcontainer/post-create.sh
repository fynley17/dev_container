#!/bin/bash

# Authenticate with GitHub CLI
gh auth login

# Prompt for repository creation or cloning
GITHUB_USERNAME=$(gh auth status 2>&1 | grep 'Logged in to github.com as' | awk '{print $NF}')
echo 'Would you like to create a new repository or use an existing one? (new/existing)'
read REPO_CHOICE

if [ "$REPO_CHOICE" = "new" ]; then
  echo 'Enter new repository name:'
  read NEW_REPO
  gh repo create "$NEW_REPO" --public --source .
  git clone "https://github.com/$GITHUB_USERNAME/$NEW_REPO.git" .
else
  echo 'Enter existing repository URL:'
  read EXISTING_REPO_URL
  git clone "$EXISTING_REPO_URL" .
fi
