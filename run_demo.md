## start gazebo
gazebo worlds/block_world.sdf

## start ROS -> bridge
ros2 run ros_gz_bridge parameter_bridge \
    /block/cmd_vel@geometry_msgs/msg/Twist@gz.msgs.Twist

## run teleop
ros2 run teleop_twist_keyboard teleop_twist_keyboard \
    --ros-args -r cmd_vel:=/block/cmd_vel
