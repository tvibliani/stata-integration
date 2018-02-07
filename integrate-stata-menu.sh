#!/bin/bash
##
# Install Stata deskop menu entries and add mime type associations for Stata files.
##

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with administrator rights!" 1>&2
    exit 1
fi



