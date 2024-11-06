FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, Git, gnupg, ca-certificates, and curl
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php git gnupg ca-certificates curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add GitHub CLI key and repository
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Update package lists and install GitHub CLI
RUN apt-get update && \
    apt-get install -y gh

# Set up Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite

# Remove default content from /var/www/html
RUN rm -rf /var/www/html/*

# Debugging: List contents of .devcontainer before copying
RUN echo "Listing contents of .devcontainer before COPY:" && ls -al .devcontainer/

# Copy the post-create.sh script into the container
COPY ["./.devcontainer/post-create.sh", "/workspace/.devcontainer/post-create.sh"]

# Verify the file is copied correctly
RUN echo "Listing contents of /workspace/.devcontainer after COPY:" && ls -al /workspace/.devcontainer/

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Expose the web server ports
EXPOSE 80 5500

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
