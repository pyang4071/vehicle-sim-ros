xhost +SI:localuser:root 
# allows docker to use the x server 


sudo --preserve-env=DISPLAY --preserve-env=XAUTHORITY docker run -it --rm \
  -v $(pwd):/sim_ws \
  -w /sim_ws \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $XAUTHORITY:/root/.Xauthority \
  --net=host \
  vehicle-dev


# flags
# it - creates an interactive shell
# rm - remove container afterwards
# v flags 
#   mounts the file/directory so edits on both docker and normal fs is synced
# w - define the workspace
# e export environment variables
# name of docker image
