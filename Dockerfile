FROM ubuntu:17.04


ENV RHEL_DIR=/rhel
##ENV http_proxy=http://128.132.9.10:8080
##ENV https_proxy=http://128.132.9.10:8080
#VOLUME /mnt:/mnt

RUN apt-get -y update && apt-get -y dist-upgrade && apt-get install -y yum rpm
##RUN apt-get -y install vim
RUN apt-get -y autoclean && apt-get -y autoremove && rm -rf /var/lib/dpkg /var/lib/apt

ADD src /scripts
RUN chmod 700 /scripts/script.sh

CMD [ "echo", "hello" ]
CMD ["/scripts/script.sh"]

