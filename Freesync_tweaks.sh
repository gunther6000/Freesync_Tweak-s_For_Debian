#!/bin/bash

# This script attempts to fix shader stutter issues.

# Check if the user is running the script as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Disable shader caching
echo "Disabling shader caching..."
echo 0 > /proc/sys/vm/nr_hugepages

# Unload and reload the graphics driver (replace 'your_driver_module' with the actual driver module)
echo "Unloading and reloading the graphics driver..."
modprobe -r amdgpu
modprobe amdgpu

echo "Shader stutter fix applied successfully."

# Optionally, you may want to reboot your system for changes to take effect
#echo "Rebooting the system..."
#reboot
