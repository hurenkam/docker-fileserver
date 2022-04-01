FROM docker.io/hurenkam/debian-cockpit
MAINTAINER Mark Hurenkamp <mark.hurenkamp@xs4all>

# install fileserver related packages
# avahi / nfs / afp / samba
RUN apt-get update && apt-get install -y \
	avahi-daemon \
	avahi-utils \
	libnfs-utils \
	netatalk \
	nfs-kernel-server \
	samba 

# install wsdd daemon
# this will announce the samba shares using SMB2 protocol
RUN echo "deb https://pkg.ltec.ch/public/ bullseye main" > /etc/apt/sources.list.d/wsdd.list
RUN apt-key adv --fetch-keys https://pkg.ltec.ch/public/conf/ltec-ag.gpg.key
RUN apt-get update && apt-get install -y wsdd

# install cockpit-file-sharing
RUN apt-get update && apt-get install -y \
	git \
	make

RUN cd /root && git clone https://github.com/45Drives/cockpit-file-sharing.git && cd cockpit-file-sharing && make install

# clean-up
RUN apt-get remove -y git make && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /var/log/alternatives.log \
    /var/log/apt/history.log \
    /var/log/apt/term.log \
    /var/log/dpkg.log
    /root/cockpit-file-sharing

# copy overlay directories
COPY etc/ /etc/



# Build final image.
# Create an image without the deleted files in the intermediate layers.

FROM docker.io/hurenkam/debian-cockpit
COPY --from=0 / /


# expose ssh port
EXPOSE 22

# expose samba ports
EXPOSE 445 137/udp 138/udp

# expose afp port
EXPOSE 548

# expose nfs ports
EXPOSE 111 2049 32765 32766 32767 32768

# expose cockpit port
EXPOSE 9090


# configure systemd
ENV container docker
STOPSIGNAL SIGRTMIN+3


VOLUME ["/sys/fs/cgroup"] 

CMD [ "/sbin/init" ]


# TODO:
# - set root password

