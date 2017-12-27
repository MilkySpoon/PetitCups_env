FROM amazonlinux

RUN yum -y update
RUN yum -y install httpd24 git go vi
RUN service httpd start
RUN useradd client
# COPY httpd.conf /etc/httpd/conf/httpd.conf
EXPOSE 80
CMD ["/bin/bash"]
