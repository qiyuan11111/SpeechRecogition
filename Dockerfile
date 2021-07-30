FROM ubuntu:20.04
MAINTAINER qiyuan
COPY autosub /home/share/lmcproject/Task_one/autosub
COPY tomcat/apache-tomcat-8.5.69.tar.gz /usr/local/apache-tomcat-8.5.69.tar.gz
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i 's#http://archive.ubuntu.com/#http://mirrors.tuna.tsinghua.edu.cn/#' /etc/apt/sources.list && cd /usr/local \
	&& apt-get update --fix-missing && apt-get install -y openjdk-8-jdk vim python3-pip ffmpeg imagemagick --fix-missing \
	&& pip3 install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
	&& pip install -r /home/share/lmcproject/Task_one/autosub/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
	&& tar -zxvf /usr/local/apache-tomcat-8.5.69.tar.gz
COPY tomcat/startup.sh /usr/local/apache-tomcat-8.5.69/bin/startup.sh
COPY tomcat/start.sh /usr/local/apache-tomcat-8.5.69/bin/start.sh
COPY tomcat/java.security /etc/java-8-openjdk/security/java.security
COPY imagemagick/policy.xml /etc/ImageMagick-6/policy.xml
RUN chmod 777 -R /usr/local/apache-tomcat-8.5.69
EXPOSE 8080
CMD ["/bin/sh", "/usr/local/apache-tomcat-8.5.69/bin/start.sh"]
