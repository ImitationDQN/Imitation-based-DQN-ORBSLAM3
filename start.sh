#!/bin/bash
cat /dev/null > abc.txt
cat /dev/null > abc2.txt
rm -ff /home/kanwal/frames/*
rm -ff /home/kanwal/ORB_SLAM/bin/TrackLost.jpg
rm -ff /home/kanwal/ORB_SLAM/bin/Tracking.jpg
clear
echo "Deleting Images"
rm -ff /home/kanwal/frames/*
echo "deleted Images"

echo "Starting ROSCORE"
roscore &
sleep 2

echo "Started ROSCORE"
cd /home/minos             #Following command runs MINOS


#move automtically

python3 -m minos.tools.pygame --dataset mp3d --scene_ids 2t7WUuJeko7 --env_config pointgoal_mp3d_s   -s map  --navmap --save_png --width 600 --height 400 --agent_config agent_continuous  --train=True &

cd /home/ORB_SLAM3          #Following command runs ORB_SLAM after a 10 second delay
sleep 5
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/home/
rosrun ORB_SLAM3 Mono /home/kay/ORB_SLAM3/Vocabulary/ORBvoc.txt /home/kay/ORB_SLAM3/Examples_old/Monocular/Minos.yaml &
sleep 5                        #Following command runs the integration algorithm after a 10 second delay
cd /home/catkin_ws
source devel/setup.bash
rosrun merger_node merger_node

echo "$ROS_PACKAGE_PATH"
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/home/kanwal/ORB_SLAM3
export ROS_PACKAGE_PATH=/home/kanwal/ORB_SLAM:${ROS_PACKAGE_PATH} 

