FROM ubuntu:latest

# Install Apache and other dependencies if needed
RUN apt-get update && apt-get install -y apache2 wget unzip

# Download the covid19.zip file
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip

# Remove existing content from /var/www/html
RUN rm -rf /var/www/html/*

# Unzip the covid19.zip file into /var/www/html/
RUN unzip covid19.zip -d /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Set Apache as the default command
CMD ["apache2ctl", "-D", "FOREGROUND"]
