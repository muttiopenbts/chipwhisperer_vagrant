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
Then reload udev system. Refer to project readme.
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
## TODO
Complete this readme with better detailed steps.
