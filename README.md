# chipwhisperer_vagrant
Example vagrant file(s) for setting up a chipwhisperer inside a vm.

## Requirements
1. Internet connectivity
2. Ubuntu OS 24.04 for host system
3. Host OS with KVM enabled
4. Host OS with Vagrant installed

## Setup
```sh
git clone https://github.com/muttiopenbts/chipwhisperer_vagrant.git
```
Bring up Ubuntu guest os
```sh
cd chipwhisperer_vagrant/ubuntu-2204
vagrant up
```
Enable usb hotplug for chipwhisperer inside vm guest
```sh
git clone https://github.com/muttiopenbts/usb-libvirt-hotplug
```
Copy udev script
```sh
sudo mkdir /opt/usb-libvirt-hotplug
sudo cp usb-libvirt-hotplug/usb-libvirt-hotplug.sh /opt/usb-libvirt-hotplug
```
Add udev rule for chipwhisperer
```sh
sudo cp chipwhisperer_vagrant/50-newae.rules /etc/udev/rules.d/
```
From Host OS edit udev rule to reflect vm that chipwhisperer should be connected to.
You will first need to determine the vm name that should be set in the udev rule.
Obtaining the vm name
```sh
virsh list --all
 Id   Name                  State
-------------------------------------
 1    ubuntu-2204_default   running
```
Now replace ENV{CW_VM_NAME}="MY_VM" with ENV{CW_VM_NAME}="ubuntu-2204_default"
```sh
vi /etc/udev/rules.d/50-newae.rules
```
Then reload Host OS udev system.
```sh
sudo sh -c 'udevadm control --reload-rules && udevadm trigger'
```
## Start Jupyter notebooks from VM guest
Login to vm from host os
```sh
cd chipwhisperer_vagrant/ubuntu-2204
vagrant ssh
```
Start jupyter service
```sh
cd /vagrant_data/chipwhisperer
jupyter-lab &
```
An alternative to have jupyter start on all network interfaces
```sh
jupyter-lab --ip 0.0.0.0
```
## Browse to Jupyter notebook
Open a browser on the host os and you should be able to connect to the notebook on http://127.0.0.1:8888. You will need the jupyter token that will have been flashed on the terminal screen when you ran jupyter-lab command.

# Trouble
Notebook doesn't open in browser.
The vagrant file has an entry to port redirect from host os 127.0.0.1:8888 to the vm 127.0.0.1:8888.  
When the jupyter-lab service starts up, make sure it is listening on port 8888 and nothing else.  
You can fix this by killing any jupter-lab process running on the vm and then restarting jupyter-lab as described above.
## TODO
Complete this readme with better detailed steps.
