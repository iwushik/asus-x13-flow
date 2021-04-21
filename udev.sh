#!/bin/sh

if [ "$1" = "-u" ]; then
	rm /etc/udev/rules.d/99-asus-flow-power.rules
else
	mkdir -p /etc/udev/rules.d

	cat <<- EOF > /etc/udev/rules.d/99-asus-flow-power.rules
	# nvidia dGPU
	ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{vendor}=="0x10de", ATTR{power/control}="auto"
	EOF
	
	cat <<- EOF >> /etc/udev/rules.d/99-asus-flow-power.rules
	# nvme ssd
	ACTION=="add", SUBSYSTEM=="pci", DRIVER=="nvme", TEST=="power/control", ATTR{power/control}="auto"
	EOF
	
	udevadm control --reload
fi
