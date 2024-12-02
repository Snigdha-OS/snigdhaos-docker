# Stage 1: Build the root filesystem
FROM archlinux:base-devel AS rootfs

# Update system and install base packages
RUN pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm pacman-contrib git openssh sudo curl

# Add custom pacman configuration
COPY pacman.conf /etc/pacman.conf

# Download and configure the Snigdha OS mirrorlist
RUN curl -fsSL https://raw.githubusercontent.com/Snigdha-OS/snigdhaos-pkgbuilds/refs/heads/master/snigdhaos-mirrorlist/snigdhaos-mirrorlist \
    -o /etc/pacman.d/snigdhaos-mirrorlist

# Initialize pacman keyring and trust Snigdha OS signing key
RUN pacman-key --init && \
    pacman-key --recv-keys E1415F19F21171F2 --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key E1415F19F21171F2

# Install Snigdha OS-specific packages and keyring
RUN pacman -Sy && \
    pacman -S --needed --noconfirm snigdhaos-keyring snigdhaos-mirrorlist && \
    pacman -Syu --noconfirm

# Add Chaotic AUR repository
RUN pacman-key --recv-keys 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key 3056513887B78AEB && \
    curl -fsSL 'https://aur.chaotic.cx/chaotic-aur.gpg' | pacman-key --add - && \
    echo '[chaotic-aur]' >> /etc/pacman.conf && \
    echo 'Server = https://aur.chaotic.cx/$arch' >> /etc/pacman.conf && \
    pacman -Sy --noconfirm chaotic-keyring && \
    pacman -Syu --noconfirm

# Add BlackArch repository
RUN curl -fsSL https://blackarch.org/strap.sh -o /tmp/strap.sh && \
    chmod +x /tmp/strap.sh && \
    ./tmp/strap.sh && \
    pacman -Syu --noconfirm

# Clean up cache and temporary files to reduce image size
RUN rm -rf /var/lib/pacman/sync/* && \
    find /var/cache/pacman/ -type f -delete && \
    pacman -Sc --noconfirm

# Stage 2: Create the final minimal container
FROM scratch

# Metadata about the container
LABEL org.opencontainers.image.title="Snigdha OS with BlackArch and Chaotic AUR" \
      org.opencontainers.image.description="Snigdha OS - Arch-based Linux distribution for Penetration Testing and Ethical Hacking, with BlackArch and Chaotic AUR repositories preconfigured" \
      org.opencontainers.image.version="1.0" \
      org.opencontainers.image.authors="Snigdha OS Team" \
      org.opencontainers.image.licenses="MIT"

# Copy the prepared root filesystem
COPY --from=rootfs / /

# Default command
CMD ["/usr/bin/bash"]
