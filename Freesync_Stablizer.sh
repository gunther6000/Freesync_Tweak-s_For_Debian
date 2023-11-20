#!/bin/bash

# Set the desired refresh rate (replace 144 with your target refresh rate)
target_refresh_rate=144

# Get the name of your display (you may need to adjust this)
display_name=$(xrandr | grep " connected" | awk '{ print$1 }')

# Check if amdgpu-pro is loaded (this may vary based on your system and GPU driver)
if lsmod | grep amdgpu_pro; then
  # Set the refresh rate using xrandr
  xrandr --output $display_name --mode $target_refresh_rate
else
  echo "amdgpu-pro not loaded. Make sure you have the correct driver installed."
fi
