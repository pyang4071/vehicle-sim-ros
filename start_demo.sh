#!/bin/bash

# Name of the tmux session
SESSION="block_garden"

# World file path (update to your workspace)
WORLD_PATH="/sim_ws/worlds/block_world.sdf"

# ROS2 namespace for the block
BLOCK_NS="/block"

# Kill any existing session with the same name
tmux kill-session -t $SESSION 2>/dev/null

# Start a new tmux session, detached
tmux new-session -d -s $SESSION

# Pane 0: Gazebo Garden
tmux send-keys -t $SESSION "gz sim $WORLD_PATH" C-m

# Split horizontally: Pane 1 → ROS2 bridge
tmux split-window -h -t $SESSION
tmux send-keys -t $SESSION:0.1 "ros2 run ros_gz_bridge parameter_bridge $BLOCK_NS/cmd_vel@geometry_msgs/msg/Twist@gz.msgs.Twist" C-m

# Split vertically in pane 0: Pane 2 → teleop
tmux select-pane -t $SESSION:0.0
tmux split-window -v -t $SESSION
tmux send-keys -t $SESSION:0.2 "ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -r cmd_vel:=$BLOCK_NS/cmd_vel" C-m

# Select the Gazebo pane
tmux select-pane -t $SESSION:0.0

# Attach to the session
tmux attach-session -t $SESSION
