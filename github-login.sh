#!/bin/bash

# Function to check if the user is already logged in
check_login_status() {
  echo "Checking GitHub login status..."

  # Check if the user is already authenticated with GitHub CLI
  gh auth status &>/dev/null
  if [ $? -eq 0 ]; then
    echo "You are already logged into GitHub!"
  else
    echo "You are not logged in. Opening terminal for interactive login..."
    # If not logged in, ensure any existing GITHUB_TOKEN is unset
    unset GITHUB_TOKEN
    # Open a new terminal to allow the user to log in interactively
    open_login_terminal
  fi
}

# Function to open a new terminal for GitHub login
open_login_terminal() {
  # Check which terminal is available and use it to open a new terminal for login
  if command -v gnome-terminal &> /dev/null; then
    gnome-terminal -- bash -c "gh auth login --web; bash"
  elif command -v xterm &> /dev/null; then
    xterm -e "gh auth login --web; bash"
  elif command -v konsole &> /dev/null; then
    konsole --hold -e "gh auth login --web"
  else
    echo "No supported terminal emulator found. Please install gnome-terminal, xterm, or konsole."
    exit 1
  fi
}

# Function to get the GitHub username of the logged-in user
get_github_username() {
  # Retrieve the authenticated GitHub username using GitHub CLI
  username=$(gh api user --jq '.login')

  if [ -z "$username" ]; then
    echo "Failed to get GitHub username. Exiting script."
    exit 1
  fi

  echo "Authenticated as: $username"
}

# Ask the user whether they want to use an existing repository or create a new one
choose_repo() {
  echo "Do you want to use an existing repository or create a new one?"
  echo "1. Use an existing repository"
  echo "2. Create a new repository"
  
  # Open a new terminal for user input
  open_choice_terminal

  # Read user input for repository choice
  read -p "Please enter your choice (1 or 2): " choice

  if [ "$choice" -eq 1 ]; then
    # Let the user input their existing repository
    read -p "Enter the name of your existing repository (e.g., 'username/repo'): " repo_name
    echo "Cloning repository '$repo_name'..."
    git clone "https://github.com/$repo_name.git" .  # Cloning into current directory
    echo "Repository '$repo_name' cloned successfully!"
  elif [ "$choice" -eq 2 ]; then
    # Let the user create a new repository
    read -p "Enter a name for your new repository: " new_repo_name
    echo "Creating new repository '$new_repo_name'..."
    gh repo create "$username/$new_repo_name" --public --clone
    echo "Repository '$new_repo_name' created and cloned successfully!"
  else
    echo "Invalid choice, exiting script."
    exit 1
  fi
}

# Function to open a new terminal for repository choice
open_choice_terminal() {
  # Check which terminal is available and use it to open a new terminal for the repo choice
  if command -v gnome-terminal &> /dev/null; then
    gnome-terminal -- bash -c "echo 'Choose an option for your repository: 1 for existing or 2 for new.'; read; bash"
  elif command -v xterm &> /dev/null; then
    xterm -e "echo 'Choose an option for your repository: 1 for existing or 2 for new.'; read; bash"
  elif command -v konsole &> /dev/null; then
    konsole --hold -e "echo 'Choose an option for your repository: 1 for existing or 2 for new.'; read; bash"
  else
    echo "No supported terminal emulator found. Please install gnome-terminal, xterm, or konsole."
    exit 1
  fi
}

# Remove the placeholder repo after use
remove_placeholder_repo() {
  echo "Removing the placeholder repository..."
  rm -rf ./.devcontainer  # Remove the .devcontainer that was cloned in
  rm -f github-login.sh   # Remove the script itself
}

# Main script execution
check_login_status
get_github_username
choose_repo
remove_placeholder_repo
echo "Setup complete!"
