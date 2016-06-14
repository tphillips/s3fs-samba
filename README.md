# s3fs-samba
A docker container which mounts an s3 bucket and shares it using samba

To use:

* Add your s3 credentials to the passwd-s3fs file
* Add your bucket name to the fstab-add file
* run ./cleanBuildRun.sh
* The container will start and ask you to set the password for the storageuser
* By default the access username is "storageuser" and the share is "Storage"
* Use ctrl+P Q to background the container, typing exit will stop it

Note that:

* The s3fs mount is configure to use a local cache at /mnt/s3fs-tmp and according to https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ this is unbounded!  This can be turned off in the fstab-add file
* The s3fs mount is configured to use reduced redundancy storage. This can me modified in the fstab-add file
