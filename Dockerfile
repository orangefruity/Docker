[root@ip-172-31-31-116 abc]# cat Dockerfile
FROM centos:6.9
RUN yum install java -y
RUN yum install httpd -y
RUN yum install vim -y
RUN yum install wget -y
RUN yum install initscripts -y
RUn yum install net-tools -y
#RUN echo  "checking for httpd" > /var/www/html/index.html
COPY test104/ /var/www/html
RUN chown -R apache:apache /var/www/html/test104
RUN sed -i 's/AllowOverride None/AllowOverride ALL/g' /etc/httpd/conf/httpd.conf
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm -y
RUN yum install yum-utils -y
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd"]

###################### @nd example ##############
FROM python:3.7.0-alpine3.8

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=app.py

CMD flask run --host=0.0.0.0
