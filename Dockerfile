FROM ubuntu:trusty
MAINTAINER kalininsn@gmail.com 
ENV KAPACITOR_VERSION=kapacitor_0.12.0-1 
ENV KAPACITOR_FILE=${KAPACITOR_VERSION}_amd64.deb 
EXPOSE 9092 
USER root 
WORKDIR /tmp 
RUN apt-get update && \
    apt-get install -y init-system-helpers curl python-pip wget python-dev git && \
    wget --quiet https://s3.amazonaws.com/kapacitor/${KAPACITOR_FILE} && \ 
    dpkg -i ${KAPACITOR_FILE} && \ 
    apt-get autoremove && \ 
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
COPY entrypoint.sh /entrypoint.sh 
RUN chmod +x /entrypoint.sh 
WORKDIR /opt/kapacitor 
CMD [ "kapacitord", "-config", "/etc/kapacitor/kapacitor.conf" ]
