FROM ubuntu:latest

RUN apt-get update; apt-get install -y git automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config samba fuse; apt-get clean
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git; cd s3fs-fuse; ./autogen.sh; ./configure; make; make install
RUN useradd -ms /bin/bash storageuser
RUN mkdir /mnt/s3fs-data; mkdir /mnt/s3fs-tmp; chmod -R 777 /mnt/s3fs-tmp; chown -R storageuser /mnt/s3fs-data

EXPOSE 139
EXPOSE 445

ADD passwd-s3fs /etc/passwd-s3fs
ADD fstab-add ./fstab-add
ADD smb-config-add ./smb-config-add
ADD start.sh /start.sh

RUN chmod 600 /etc/passwd-s3fs; cat ./fstab-add >> /etc/fstab; cat ./smb-config-add  >> /etc/samba/smb.conf

CMD /start.sh


