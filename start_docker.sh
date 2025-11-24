xhost +local:docker 
# allows docker to use the x server 

docker run -it --rm \
  -v $(pwd):/sim_ws \
  -w /sim_ws \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  vehicle-dev


# flags
# it - creates an interactive shell
# rm - remove container afterwards
# v flags 
#   mounts the file/directory so edits on both docker and normal fs is synced
# w - define the workspace
# e export environment variables
# name of docker image
