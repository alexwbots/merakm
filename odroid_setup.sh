echo "Uninstall software not need for the robot."
sudo apt-get remove --purge libreoffice*
sudo apt-get update
sudo apt-get upgrade

echo "Install ROS NOETIC."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install ros-noetic-desktop
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo "Install ROS packages."
sudo apt-get install ros-noetic-joy ros-noetic-teleop-twist-joy ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc \
  ros-noetic-rgbd-launch ros-noetic-rosserial-arduino ros-noetic-rosserial-python ros-noetic-rosserial-client \
  ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
  ros-noetic-compressed-image-transport ros-noetic-rqt* ros-noetic-rviz ros-noetic-gmapping ros-noetic-navigation \
  ros-noetic-interactive-markers

echo "Creating ROS workspace."
cd
mkdir -p catkin_ws/src
cd catkin_ws
catkin_make
cd
