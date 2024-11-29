FROM archlinux:base-devel AS rootfs

# Install base utilities and dependencies
RUN pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm pacman-contrib git openssh sudo curl

# Copy a custom pacman.conf if needed
COPY pacman.conf /etc/pacman.conf

# Add Snigdha OS mirrorlist
RUN curl -o /etc/pacman.d/snigdhaos-mirrorlist \
    https://raw.githubusercontent.com/Snigdha-OS/snigdhaos-pkgbuilds/refs/heads/master/snigdhaos-mirrorlist/snigdhaos-mirrorlist

# Initialize pacman keyring, add Snigdha OS keyring, and clean up
RUN pacman-key --init && \
    pacman-key --recv-keys E1415F19F21171F2 --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key E1415F19F21171F2 && \
    pacman -Sy && \
    pacman -S --needed --noconfirm snigdhaos-keyring snigdhaos-mirrorlist && \
    pacman -Syu --noconfirm && \
    rm -rf /var/lib/pacman/sync/* && \
    find /var/cache/pacman/ -type f -delete

# Add Chaotic-AUR mirrorlist and keyring
RUN curl -o /etc/pacman.d/chaotic-mirrorlist \
    https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist && \
    pacman-key --recv-keys 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key 3056513887B78AEB && \
    echo '[chaotic-aur]' >> /etc/pacman.conf && \
    echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf && \
    pacman -Sy --needed --noconfirm chaotic-keyring && \
    pacman -Syu --noconfirm && \
    rm -rf /var/lib/pacman/sync/* && \
    find /var/cache/pacman/ -type f -delete

FROM scratch
LABEL org.opencontainers.image.description="Snigdha OS with Chaotic-AUR support - Arch-based distribution offering an easy installation, several customizations, and unique performance optimization."
COPY --from=rootfs / /
CMD ["/usr/bin/bash"]
