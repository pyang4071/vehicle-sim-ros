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

build -t [name] [location]

flags
    t : specify name 


