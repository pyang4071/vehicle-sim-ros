# set and export a varaible that points towards the X11 authentication cookie file
# needed for secure forwarding 
export XAUTHORITY=$HOME/.Xauthority

# allow the X server to trust the root user
# required to run to GUI inside docker
xhost +SI:localuser:root 

# Run the docker container
# preserve-env preserves the variables that would alternatively get wiped from using sudo 
# it flag - creates an interactive shell
# rm flag - removes the container once it is stopped
# v flag - mount the file/directory so edits on both docker and normal fs is synced
# w flag - sets the workspace in the docker container 
# e flag - passes in environment varaible
# --net - do not isolate network
# finally, the name of the docker we want to run
sudo --preserve-env=DISPLAY --preserve-env=XAUTHORITY docker run -it --rm \ 
  -v $(pwd):/sim_ws \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $XAUTHORITY:/root/.Xauthority \
  -w /sim_ws \
  -e DISPLAY=$DISPLAY \
  --net=host \
  vehicle-dev
