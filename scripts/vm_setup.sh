sudo apt-get update
sudo apt upgrade -y
sudo apt-get install tmux python3-pip -y
# chipwhisperer
sudo apt-get install build-essential gdb lcov pkg-config \
libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
lzma lzma-dev tk-dev uuid-dev zlib1g-dev curl -y
#
sudo apt install libusb-dev make git avr-libc gcc-avr \
gcc-arm-none-eabi libusb-1.0-0-dev usbutils -y
#
VAGRANT_SHARE='/vagrant_data'
CW_PATH=${VAGRANT_SHARE}'/chipwhisperer'
#
if [ ! -d "${CW_PATH}" ]; then
  echo "${CW_PATH} does not exist.\n"
  echo "Creating new clone of Chipwhisperer.\n"
  cd ${VAGRANT_SHARE}
  git clone https://github.com/newaetech/chipwhisperer
  cd ${CW_PATH}
  git submodule update --init jupyter
fi
# Prepare for usb hotplug from host to vm
cd ${CW_PATH}
sudo cp hardware/50-newae.rules /etc/udev/rules.d/50-newae.rules
sudo udevadm control --reload-rules
sudo groupadd -f chipwhisperer
sudo usermod -aG chipwhisperer $USER
sudo usermod -aG plugdev $USER
# Jupyter notebook support
sudo apt install nodejs -y
python3 -m pip install -e .
python3 -m pip install -r jupyter/requirements.txt
cd jupyter
python3 -m pip install nbstripout
python3 -m pip install -U jupyterlab
source ~/.profile
# nbstripout --install # not working
# Start chipwhisperer
# jupyter-lab & # not working
