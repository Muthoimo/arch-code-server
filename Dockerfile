FROM archlinux:latest

# Update the system and install necessary dependencies
RUN pacman-key init && pacman -Syu --noconfirm \
    base-devel \
    git \
    sudo \
    zsh \
    go \
    curl \
    --needed


# Enable en_US.UTF-8 locale
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
    && locale-gen

# Set the LANG environment variable
ENV LANG=en_US.UTF-8

#entrypoint
COPY entrypoint.sh entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create the "coder" user and configure sudo with no password
RUN useradd -m -s /bin/zsh coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/coder \
    && chmod 440 /etc/sudoers.d/coder

# Set the working directory to /home/coder
WORKDIR /home/coder

# Set the hostname to "arch"
#USER coder
#RUN echo "arch" > /etc/hostname
#hostnamectl set-hostname arch

# Set the hostname environment variable (optional)
ENV HOSTNAME=arch

# Install yay (AUR helper)
USER coder
RUN git clone https://aur.archlinux.org/yay.git \
    && cd yay \
    && makepkg -sri --needed --noconfirm \
    && cd \
    # Clean up
    && rm -rf .cache yay

# Install code-server using yay (AUR package)
RUN yay -S --noconfirm code-server

# Create the config file for code-server with password authentication
RUN mkdir -p /home/coder/.config/code-server

# Set up the entrypoint to generate a random password and set it for code-server
CMD PASSWORD=$(openssl rand -base64 16) \
    && echo "Generated password: $PASSWORD" \
    && echo "password: $PASSWORD" > /home/coder/.config/code-server/config.yaml \
    && echo "auth: password" >> /home/coder/.config/code-server/config.yaml \
    && code-server --bind-addr 0.0.0.0:8080
