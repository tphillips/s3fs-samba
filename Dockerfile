FROM ubuntu:latest
RUN apt-get update; apt-get install -y git automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config samba fuse; apt-get clean
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git; cd s3fs-fuse; ./autogen.sh; ./configure; make; make install
ADD smb-config-add /etc/samba/smb.conf.template
EXPOSE 139
EXPOSE 445
ADD start.sh /start.sh
CMD /start.sh


