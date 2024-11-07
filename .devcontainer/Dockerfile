FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, Git, gnupg, ca-certificates, curl, and GitHub CLI
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php git gnupg ca-certificates curl gh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite

# Remove default content from /var/www/html
RUN rm -rf /var/www/html/*

# Clone a placeholder repository (empty repository or a template)
RUN git clone https://github.com/fynley17/dev_container.git /var/www/html

# Make the script executable
RUN chmod +x /var/www/html/github-login.sh

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Expose the web server ports
EXPOSE 80 5500

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
