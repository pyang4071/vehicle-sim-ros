# Docker setup with ROS2 Humble

The goal of this project is to create an isolated environment with ROS2 Humble packages that one could work on without worrying about messing up their system itself. 

## Initial setup

While this project is being setup, the container is not ran on a local device obut instead on a server with docker set up. The server was a laptop on a private network. Thus, for successful ssh connection, we use a jump (-J flag) connection to a device accessible from the public internet first. We used trusted X11 forwarding flag (-Y flag) to allowing for graphical display over the ssh connection. We found the normal X11 forwarding to be insufficent for our goal. The exact command is omitted. 

## Project Setup 

This repo uses a flat layout. The porject name for this example is `vehicle_sim`
All application code should live in the [`project_name`](vehicle_sim/) directory.
The entry point of the program will be defined in [`__main__.py`](vehicle_sim/__main__.py).
and the package version is maintained in [`__init__.py`](vehicle_sim/__init__.py).

All the python dependencies should be specified in [`pyproject.toml`](pyproject.toml). 
This file follows the standard structure.


# Docker stuff

## check if docker daemon is running
sudo systemctl status docker

## run docker daemon
sudo systemctl start docker

## create a docker container
docker search ubuntu
docker pull ubuntu

# build the docker
sudo docker build -t vehicle-dev .
