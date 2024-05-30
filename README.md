# chipwhisperer_vagrant
Example vagrant file(s) for setting up a chipwhisperer inside a vm.

## Requirements
1. Internet connectivity
2. Ubuntu OS 24.04 for host system
3. Host OS with KVM enabled
4. Host OS with Vagrant installed

## Setup
```sh
git clone <this repo>
```
Bring up Ubuntu guest os
```sh
cd ubuntu-2204
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

## TODO
Complete this readme with better detailed steps.
