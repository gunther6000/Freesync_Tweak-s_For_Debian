#!/bin/bash

# This script attempts to fix shader stutter issues.

# Check if the user is running the script as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Disable shader caching
function disable_shader_caching() {
  echo "Disabling shader caching..."
  if [ -e "/proc/sys/vm/nr_hugepages" ]; then
    echo 0 > /proc/sys/vm/nr_hugepages
  else
    echo "File /proc/sys/vm/nr_hugepages does not exist."
  fi
}

# Unload and reload the graphics driver (replace 'your_driver_module' with the actual driver module)
function reload_graphics_driver() {
  local driver_module=$1
  echo "Unloading and reloading the graphics driver..."
  modprobe -r "$driver_module"
  modprobe "$driver_module"
}

disable_shader_caching
reload_graphics_driver

echo "Shader stutter fix applied successfully."

# Optionally, you may want to reboot your system for changes to take effect
#echo "Rebooting the system..."
#reboot
