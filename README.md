# docker-fileserver
Alpine Linux based Time Machine / Samba / NFS server

## Currently supports:
- Time Machine backups from my Macbook Pro
- Samba access from my Macbook Pro
- Samba access from my Windows 10 machine
- NFS access from my Ubuntu 18.04 machine

## How to use this image:
- Provide a /config directory through '-v path-to-config:/config' parameter. In this config directory you can put your afp.conf and smb.conf files, as well as users.conf and groups.conf.
- users.conf file defines users as user:uid:group:password
- groups.conf file defines groups as group:gid
- smb.conf is configuration used for samba
- afp.conf is configuration used for afp.
  
### Typical command to run this image:
- docker run -d --privileged --net=host -v /exports:/exports -v /etc/fileserver-config:/config hurenkam/fileserver:latest

## Credits:
Before i put this together, i studied docker & alpine documentation, as well as several other docker images. 
Some of the ideas and scripts in this image are based on these other images:
- https://hub.docker.com/r/mbentley/timemachine/
- https://hub.docker.com/r/kartoffeltoby/docker-nas-samba/
- https://hub.docker.com/r/fuzzle/docker-nfs-server/
