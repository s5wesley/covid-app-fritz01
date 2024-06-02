# Stage 1: Build stage
FROM ubuntu:latest AS builder

# Set the maintainer label
LABEL maintainer="wesleymbarga@gmail.com"

# Update package index and install required packages
RUN apt-get update && apt-get install -y wget unzip

# Download the application zip file
RUN wget -O /tmp/covid19.zip https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip

# Unzip the application
RUN unzip /tmp/covid19.zip -d /app

# Stage 2: Final stage
FROM gcr.io/distroless/static-debian12

# Copy the application files from the build stage
COPY --from=builder /app /var/www/html

# Expose port 80 to the outside world
EXPOSE 80

# Use distroless image entrypoint and command to start Apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
