docker run -it --rm \
  -v $(pwd)/vehicle_sim:/sim_ws/vehicle_sim \
  -v $(pwd)/pyproject.toml:/sim_ws/pyproject.toml \
  -w /sim_ws \
  vehicle_sim


# flags
# it - creates an interactive shell
# rm - remove container afterwards
# v flags 
#   mounts the file/directory so edits on both docker and normal fs is synced
# w - define the workspace
# name of docker image
