==>Sample project for Docker file

=> create a new directory
#mkdir project1

=>Go to project directory
#cd project1

=> create a docker file here 
#vi Dockerfile
#Set the image to ubuntu
FROM ubuntu:14.04

#Update the repository sources list
RUN apt-get update

######### BEGIN INSTALLATION ##################
#install openjdk
RUN apt-get install -y default-jdk

#install git and maven
RUN apt-get install -y git maven

#Create the default data directory
RUN mkdir -p /data/

#switch to new diectory
WORKDIR /data

#perform git clone
RUN git clone https://github.com/anilbidari/CloudenabledWebApp.git


#switch to cloudenabledwebapp directory
WORKDIR /data/CloudenabledWebApp

#use maven package
RUN mvn package

#install tomcat7
RUN apt-get install -y tomcat7

#switch to cloudenabledwebapp directory
WORKDIR /data/CloudenabledWebApp/target/

#copy war file
RUN cp /data/CloudenabledWebApp/target/CloudenabledWebApp.war /var/lib/tomcat7/webapps

#Expose the default port
EXPOSE 8080

#Default port to execute the entrypoint
CMD ["--port 8080"]

#Set default container command
ENTRYPOINT /bin/bash


############ INSTALLATION END ######################

=>Build new image
#docker build -t my-webapp .

=>checking image status
# docker images

=> now run the new container using my-webapp images and port forwording
#docker run -itd --name web-host -p 5004:8080 my-webapp

=> Now starts the tomcat service
#docker exec -it web-host service tomcat7 start

=> checking output
   url= 52.15.60.226:5004/CloudenabledWebApp


##################################################MORE EXAMPLES #############################################
[root@ip-172-31-31-116 abc]# cat Dockerfile
FROM centos:6.9
RUN yum install default-jdk -y
RUN yum install httpd -y
RUN yum install vim wget -y
RUN yum install initscripts -y
RUn yum install net-tools -y
#RUN echo  "checking for httpd" > /var/www/html/index.html
COPY test104/ /var/www/html
RUN chown -R apache:apache /var/www/html/test104
RUN sed -i 's/AllowOverride None/AllowOverride ALL/g' /etc/httpd/conf/httpd.conf
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm -y
RUN yum install yum-utils -y
EXPOSE 80
#ENTRYPOINT ["/usr/sbin/httpd"]

###################### 2nd example ##############
# Use an official python runtime as a parent image
FROM python:2.7-slim

# Set the working directory to /app
WORKDIR /app

# Copy the content directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirementd.txt

# Make part 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME world
ENV NAME1 world1

#Run app.py when the container lanches
CMD ("python", "app.py")


###################### 3rd example ##############
FROM python:3.7.0-alpine3.8

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=app.py

CMD flask run --host=0.0.0.0
