# Use the official Ubuntu image
FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3 \
    python3-pip \
    sshpass \
    git \
    curl \
    openssh-client \
    sudo \
    && apt-get clean

# Install Ansible using pip
RUN pip3 install --no-cache-dir ansible

# Create a non-root user for running Ansible
RUN useradd -ms /bin/bash ansible && echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ansible
WORKDIR /home/ansible

# Copy playbooks or inventories here if needed
# COPY ./your-ansible-stuff /home/ansible/

# Default command (override in docker run if needed)
CMD [ "bash" ]

# Expose a port (e.g., 8000) if your setup needs it
EXPOSE 8000
