sudo docker stop s3fs-samba
sudo docker rm s3fs-samba
sudo docker run --name s3fs-samba --privileged -p 139:139 -p 445:445 -t -i tphillips/s3fs-samba
