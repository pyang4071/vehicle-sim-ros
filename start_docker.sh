docker run -it --rm \
  -v $(pwd):/sim_ws \
  -w /sim_ws \
  vehicle-dev


# flags
# it - creates an interactive shell
# rm - remove container afterwards
# v flags 
#   mounts the file/directory so edits on both docker and normal fs is synced
# w - define the workspace
# name of docker image
