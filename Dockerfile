FROM ubuntu:latest

RUN apt-get update; apt-get install -y git automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config samba fuse
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git
RUN mkdir /mnt/s3fs-data; mkdir /mnt/s3fs-tmp; chmod -R 777 /mnt/s3fs-tmp

RUN cd s3fs-fuse; ./autogen.sh; ./configure; make; make install

EXPOSE 139
EXPOSE 445

RUN useradd -ms /bin/bash storageuser
RUN chown -R storageuser /mnt/s3fs-data

ADD passwd-s3fs /etc/passwd-s3fs
RUN chmod 600 /etc/passwd-s3fs
ADD fstab-add ./fstab-add
RUN cat ./fstab-add >> /etc/fstab

ADD smb-config-add ./smb-config-add
RUN cat ./smb-config-add  >> /etc/samba/smb.conf

ADD start.sh /start.sh

CMD /start.sh


