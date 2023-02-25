echo "Uninstall software not need for the robot."
sudo apt-get remove -y --purge libreoffice*
sudo apt-get update
sudo apt-get upgrade -y

echo "Install ROS NOETIC."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install -y curl git
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install -y ros-noetic-desktop
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo "Install ROS packages."
sudo apt-get install -y ros-noetic-joy ros-noetic-teleop-twist-joy ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc \
  ros-noetic-rgbd-launch ros-noetic-rosserial-arduino ros-noetic-rosserial-python ros-noetic-rosserial-client \
  ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
  ros-noetic-compressed-image-transport ros-noetic-rqt* ros-noetic-rviz ros-noetic-gmapping ros-noetic-navigation \
  ros-noetic-interactive-markers

echo "Creating ROS workspace."
cd
mkdir -p catkin_ws/src
cd catkin_ws
catkin_make
echo "source /home/odroid/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
cd

echo "Enable automatic wifi connection"
echo "allow-hotplug wlan0" >> /etc/network/interface
echo "iface wlan0 inet dhcp" >> /etc/network/interface
echo "wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" >> /etc/network/interface
echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'update_config=1' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo ' ' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'network={' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo '  ssid="ALEXANDER.-AC"' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo '  psk="norecuerdo"' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo '  key_mgmt=WPA-PSK' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo '}' >> /etc/wpa_supplicant/wpa_supplicant.conf

echo "Enable I2C ???"

echo "Install additional packages"
sudo apt-get install -y openssh-client
sudo apt install software-properties-common
sudo add-apt-repository ppa:hardkernel/ppa
sudo apt update
sudo apt install -y odroid-wiringpi libwiringpi-dev
sudo apt install -y python3-pip
pip install odroid-wiringpi

echo "Install Arduino-ROS"
cd
wget https://downloads.arduino.cc/arduino-1.8.19-linuxaarch64.tar.xz
tar -xf arduino-1.8.19-linuxaarch64.tar.xz
cd arduino-1.8.19
sudo ./install.sh
cd
sudo apt-get install -y ros-${ROS_DISTRO}-rosserial-arduino ros-${ROS_DISTRO}-rosserial
cd 
mkdir -p Arduino/libraries
rosrun rosserial_arduino make_libraries.py .
