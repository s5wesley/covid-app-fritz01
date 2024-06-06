FROM  ubuntu
RUN apt update -y
RUN apt install -y unzip wget  apache2
WORKDIR  /var/www/html
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip
RUN unzip covid19.zip
RUN cp -r covid19/* /var/www/html
RUN rm -rf covid19.zip
COPY . .

expose 80

CMD ["apache2ctl", "-D", "FOREGROUND"]