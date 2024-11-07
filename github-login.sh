#!/bin/bash

# Start Apache service
echo "Starting Apache..."
apache2 start

# Authenticate with GitHub CLI
echo "Starting GitHub authentication..."
gh auth login --with-token < /path/to/github-token.txt

echo "GitHub CLI and Apache setup complete"
