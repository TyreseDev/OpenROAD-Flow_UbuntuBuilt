# OpenROAD Flow Docker Image

This Docker image provides an Ubuntu 20.04 environment with VNC server support, pre-configured to work with The OpenROAD Project's open-source EDA tools.

## Image Details

- **Base Image:** `tyrese3915/ubuntu-vnc-server:20.04`
- **Author:** TyreseJin (`tyresejin3915@gmail.com`)

## Features

- Ubuntu 20.04 base with VNC server.
- Non-root user `ubuntu` pre-configured.
- OpenROAD Flow scripts cloned and set up.
- Tools pre-built: yosys and openroad.

## Default Credentials

- **VNC User:** `ubuntu`
- **VNC Password:** `123456`
- **Root Password:** `root`

## Build Arguments

- `VNC_USER`: The username for the VNC user.
- `VNC_PASSWORD`: The password for the VNC server.
- `VNC_SCREEN_GEOMETRY`: The VNC screen size (default is `1366x768`).
- `VNC_COL_DEPTH`: The VNC color depth (default is `24`).

## Environment Variables

- `USER`: The active user.
- `HOME`: The home directory.
- `VNC_SCREEN_GEOMETRY`: The VNC screen size.
- `VNC_COL_DEPTH`: The VNC color depth.
- `DISPLAY`: The display number for VNC.

## Ports

- `5901`: VNC server.
- `22`: SSH server (if configured).

## Installing the Docker Image (Offline)

To install and use this Docker image on a local system without internet access, follow these steps:

### 1. Load the Docker Image

First, you'll need to load the docker image from the tar file (`open-road-flow_ubuntu-built_20.04.tar`) that you've previously saved:

```sh
docker load < open-road-flow_ubuntu-built_20.04.tar
```

### 2. Run the Docker Container

Run the following command to start a container with the VNC server enabled:

```sh
docker run -d -p 5901:5901 -p 22:22 --name openroad-flow-container open-road-flow_ubuntu:20.04
```

Replace `open-road-flow_ubuntu:20.04` with the correct image name/tag if different.

### 3. Connect to the VNC Server

Connect to the VNC server using a VNC client. Enter the VNC server address as `localhost:5901` and the password `123456` (unless you've set a different one).

### 4. Using OpenROAD Flow in the Container

After connecting to the container using VNC, open a terminal window and run the following commands to start using OpenROAD Flow:

```sh
cd ~/OpenROAD-flow-scripts
source ./env.sh
yosys -help
openroad -help
make -C flow
make -C flow gui_final
```

These commands will set up the environment, provide help messages for yosys and openroad, compile the flow, and bring up the final GUI.

For further information on using the OpenROAD tools, refer to the official documentation: [The OpenROAD Project](https://openroad-flow-scripts.readthedocs.io/)

## Customizing the Container

If you wish to customize the container environment, such as changing the default user or VNC password, you can create a new Dockerfile based on this image and redefine the ARGs and ENVs as needed. Then, build your customized image using the `docker build` command.
