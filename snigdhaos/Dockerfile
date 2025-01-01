# Stage 1: Build the root filesystem
FROM archlinux:latest AS rootfs

# Update system and install essential packages
RUN pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm base-devel pacman-contrib git openssh sudo curl

# Add custom pacman configuration
COPY pacman.conf /etc/pacman.conf

# Download and configure the Snigdha OS mirrorlist
RUN curl -fsSL https://raw.githubusercontent.com/Snigdha-OS/snigdhaos-pkgbuilds/refs/heads/master/snigdhaos-mirrorlist/snigdhaos-mirrorlist \
    -o /etc/pacman.d/snigdhaos-mirrorlist

# Initialize pacman keyring and trust Snigdha OS signing key
RUN pacman-key --init && \
    pacman-key --recv-keys 93BC54415EA8E7AB --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key 93BC54415EA8E7AB

# Install Snigdha OS-specific packages and keyring
RUN pacman -Sy && \
    pacman -S --needed --noconfirm snigdhaos-keyring snigdhaos-mirrorlist && \
    pacman -Syu --noconfirm

# Clean up cache and temporary files to reduce image size
RUN rm -rf /var/lib/pacman/sync/* && \
    find /var/cache/pacman/ -type f -delete && \
    pacman -Sc --noconfirm

# Stage 2: Create the final minimal container
FROM scratch

# Metadata about the container
LABEL org.opencontainers.image.title="Snigdha OS Container" \
      org.opencontainers.image.description="Snigdha OS - Arch-based Linux distribution for Penetration Testing and Ethical Hacking" \
      org.opencontainers.image.version="1.0" \
      org.opencontainers.image.authors="Snigdha OS Team" \
      org.opencontainers.image.licenses="MIT"

# Copy the prepared root filesystem
COPY --from=rootfs / /

# Set environment variables (optional)
ENV LANG=C.UTF-8 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Default command
CMD ["/bin/bash"]
