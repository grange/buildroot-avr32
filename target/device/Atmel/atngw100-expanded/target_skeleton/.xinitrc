#!/bin/sh

# Load your X Resource defaults, if you have them...

if [ -f $HOME/.Xdefaults ]; then
  xrdb -merge $HOME/.Xdefaults
fi

# Set the background color
xsetroot -solid steelblue

# Display the system load
torsmo &

# Start the window manager.

if [ -f /usr/bin/blackbox ] ; then
    exec /usr/bin/blackbox
fi