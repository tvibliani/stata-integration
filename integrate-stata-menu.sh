#!/bin/bash
##
# Install Stata deskop menu entries and add mime type associations for Stata files.
##

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with administrator rights!" 1>&2
    exit 1
fi

##
# Add Stata mime types
##
cp -uf stata-mimetypes.xml  /usr/share/mime/packages/

update-mime-database /usr/share/mime

##
# Add icons for stata files and menus
##
cp -uf svg/*.svg /usr/share/icons/gnome/scalable/mimetypes/

gtk-update-icon-cache /usr/share/icons/gnome -f


