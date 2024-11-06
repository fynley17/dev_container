FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, and Git
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install GitHub CLI - Split steps for clarity
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
RUN chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN apt-get update && apt-get install -y gh

# Set up Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite

# Remove default content from /var/www/html
RUN rm -rf /var/www/html/*

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Expose the web server ports
EXPOSE 80 5500

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
