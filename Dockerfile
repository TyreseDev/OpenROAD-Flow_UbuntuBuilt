# Use Ubuntu 20.04 as the base image
FROM tyrese3915/ubuntu-vnc-server:20.04
LABEL org.opencontainers.image.authors="TyreseJin (tyresejin3915@gmail.com)"

# Set default arguments
ARG VNC_USER=ubuntu
ARG VNC_PASSWORD=123456
ARG VNC_SCREEN_GEOMETRY=1366x768
ARG VNC_COL_DEPTH=24
ARG ROOT_PASSWORD=root

# Suppress interactive menus during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Set environment variables
ENV USER=${VNC_USER} \
    HOME=/home/${VNC_USER} \
    VNC_SCREEN_GEOMETRY=${VNC_SCREEN_GEOMETRY} \
    VNC_COL_DEPTH=${VNC_COL_DEPTH} \
    DISPLAY=:1

USER ${USER}

# Update the system and install required packages
RUN sudo apt update && \
    sudo apt install -y --no-install-recommends git ca-certificates
RUN sudo update-ca-certificates
RUN sudo apt autoremove --purge -y && \
    sudo apt autoclean -y && \
    sudo apt clean -y && \
    sudo rm -rf /var/lib/apt/lists/*

# Setting OpenROADFlow project
WORKDIR ${HOME}
RUN git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts
WORKDIR ${HOME}/OpenROAD-flow-scripts
RUN sudo ./setup.sh
RUN ./build_openroad.sh --local
RUN /bin/bash -c "source ./env.sh && yosys -help && openroad -help"
RUN /bin/bash -c "source ./env.sh && make -C flow"

# Expose VNC port and default SSH port
EXPOSE 5901
EXPOSE 22

ENTRYPOINT ["sudo", "-E", "/entrypoint.sh"]