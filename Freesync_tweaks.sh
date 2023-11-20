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
  local driver_module="$1"
  echo "Unloading and reloading the graphics driver..."
  
  # Check if the driver module is loaded
  if lsmod | grep -q "$driver_module"; then
    if modprobe -r "$driver_module"; then
      if modprobe "$driver_module"; then
        echo "Graphics driver reloaded successfully."
      else
        echo "Failed to reload graphics driver."
        exit 1
      fi
    else
      echo "Failed to unload graphics driver."
      exit 1
    fi
  else
    echo "Driver module $driver_module is not currently loaded."
  fi
}

# Specify the actual graphics driver module
driver_module="Mesa 23.2.1 refresh - kisak-mesa PPA"  # Replace with your actual driver module

disable_shader_caching
reload_graphics_driver "$driver_module"

echo "Shader stutter fix applied successfully."

# Optionally, you may want to reboot your system for changes to take effect
#echo "Rebooting the system..."
#reboot