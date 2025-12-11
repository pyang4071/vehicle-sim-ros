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

A basic pre-commit configuration is also included in this setup.

## Running docker

### Initial Setup 

Check if docker daemon is running with 

```
sudo systemctl status docker
```

If it is not running, start the daemon with 
```
sudo systemctl start docker
```

To build the docker image, run the shell script [`./build_docker.sh`](./build_docker.sh).
This file will build the docker using the configuration specified in [`./Dockerfile`](./Dockerfile)
Refer to that file for all the specifications

### Running Docker 

To run the docker container, run the shell script [`./run_docker.sh`](./run_docker.sh).
This would run the docker contianer with the 'sim_ws' as the workspace

## Notes

- This built environment contains multiple ros2 packages that are ready to use. 
- These include the standard ROS2 Humble topics as well as Gazebo Garden for simulation.
- The repo is mounted onto the container so changes made in the contianer are reflected in the main repo to avoid the need to save.
- Refer to each file for more detailed documentation on each step.

## Limitations

- The repo structure follows a flat layout, thus if new directories are added into the root of the repo, some parts when build the docker may not work.

## Further Steps

- Currently, there is no clear set way of creating ROS packages using `colcon build`. 
- The flat structure is a limitation when needing to better organize assets so an `src` structure may need to be adopted

## Struggles 

Creating the initial outline of the repo was straight forward, but determining how to best integrate docker and ROS into a normal python package was difficult. 
When choosing a base image, we had two main options - either a pure Ubuntu image or the ROS image. 
At first, we had used the Ubuntu image for more flexibility but setting up all of ROS properly through the dockerfile was much more difficult than expected.
Thus, we used the base ROS Humble image. 

After choosing the image, we downloading the tools and packages we would like. 
Since we are building the container multiple times to test different configurations, it was useful to break up the apt-installs into multiple lines with the most time intensive ones happening first. 
Since the build system caches the previous builds, this had saved significant time in the building process. 

We had included some ROS packages that we had though would be helpful. 
We orginally also had the original gazebo version downloaded as well.
However, we believed that this older version would not be able to work well with Humble and thus we switch to gz Garden. 

We wanted to also install all the dependencies from the pyproject into our image as well. 
Originally we had use the hatchling build system but that arose a lot of errors when trying to download the requirements and listed dependencies.
We did not figure out the exact reason for this, but we found that using `setuptools` as our build system had much less issues. 
One of the more challenging tasks was actually getting the `pip install -e .` to work as intended. 
We had the `src` structure, but it was much harder to manage when compared to the flat layout. 
Thus, for now, we decided to stick with the flat layout design. 

Our next major issue was with the display forwarding. 
Since we are connected to the server via ssh, it was difficult to pass our display variable correctly. 
We originally had use the -X flag but it was insufficent, resulting in the use of the -Y flag.

Refering to the start command form [`./run_docker.sh`](./run_docker.sh)
We are starting the docker container as `sudo` which results in losing our environment variable. 
Thus, when we choose to preverve the one that seemd relevant to the display which is XAUTHORITY and DISPLAY.
To make sure that the XAUTHORITY flag was set, we exported the env variable first.
Both of these variables were passed to start the docker container.
We had tried using only the display variable which was insufficent. 
We had also tried the same command but without the preverve functions which also did not work as intended.
Some commands that were used were potential not als important, but we did not try all the combinations.


