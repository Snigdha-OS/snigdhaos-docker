FROM archlinux:base-devel AS rootfs

RUN  pacman -Syu --noconfirm && \
     pacman -S --needed --noconfirm pacman-contrib git openssh sudo curl 
COPY pacman.conf /etc/pacman.conf 
RUN  curl https://raw.githubusercontent.com/Snigdha-OS/snigdhaos-pkgbuilds/refs/heads/master/snigdhaos-mirrorlist/snigdhaos-mirrorlist -o /etc/pacman.d/snigdhaos-mirrorlist


## include to pacman own keyring to install signed packages
RUN  pacman-key --init && \
     pacman-key --recv-keys E1415F19F21171F2 --keyserver keyserver.ubuntu.com && \
     pacman-key --lsign-key E1415F19F21171F2 && \
     pacman -Sy && \
	 pacman -S --needed --noconfirm snigdhaos-keyring snigdhaos-mirrorlist && \
	 pacman -Syu --noconfirm && \
     rm -rf /var/lib/pacman/sync/* && \
     find /var/cache/pacman/ -type f -delete

FROM scratch
LABEL org.opencontainers.image.description="Snigdha OS - Arch based Linux Distribution for Penetration Testing and Ethical Hacking"
COPY --from=rootfs / /
CMD ["/usr/bin/bash"]