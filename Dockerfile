# Use ros2 humble base image
# offical ros image from their thing - allows us to not have to manually install ros
FROM ros:humble


# set our shell to bash instead of sh
# this allows for more powerful commands that we can run
# -c means that we treat each thing after a bash command as a command instead of a string
SHELL ["/bin/bash", "-c"]

# download all the lower level dependencies we might need
# we install git, python, ros2 and dev tools
# libeigen3-dev is for c++ which ros needs i think
# finally we clean up some of the not useful stuff to make the image smaller
RUN apt-get update && apt-get install -y \
	git \
	python3-pip \
	libeigen3-dev \
	ros-humble-rviz2 \
	tmux \
	vim \
	nvim \
	&& rm -rf /var/lib/apt/list/* 

# install tools needed for the pyproject
# we are using the setuptools build system
RUN pip3 install --upgrade pip setuptools wheel build


# create a directory sim_ws for all our work to be in
# src will be where all of our module will live
RUN mkdir -p /sim_ws/src

# copy over our entire package into the src folder cheers
COPY ./src/vehicle-sim /sim_ws/src/vehicle-sim

# this would essentially set /sim_ws/src/vehicle as our default directory
# similar to cd /sim_ws
WORKSPACE /sim_ws/src/vehicle-sim

# install all the dependencies written in the pyproject
RUN pip3 install --upgrade pip
RUN pip3 install -e .
RUN pip3 install -e '.[dev]'




