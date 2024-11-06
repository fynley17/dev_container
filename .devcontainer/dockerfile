FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, sudo, and Git
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php sudo git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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
