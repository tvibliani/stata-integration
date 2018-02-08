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

##
# Create menu entries for GUI and Console versions of the Stata-IC 15
##
STATA_GUI=stata15.desktop
STATA_CONSOLE=stata15-console.desktop

cp -uf ${STATA_GUI} /usr/share/applications
cp -uf ${STATA_CONSOLE} /usr/share/applications


##
# Set Stata (GUI version) as default application for all stata files
##

mimeapps_list_file=/usr/share/applications/mimeapps.list
STATA_MIME_TYPES=("application/x-stata-do" "application/x-stata-dta" "application/x-stata-gph" "application/x-stata-smcl" "application/x-stata-stpr" "application/x-stata-stsem")
default_app=${STATA_GUI}

for mime in ${STATA_MIME_TYPES[*]};do
    grep -q "${mime}" ${mimeapps_list_file} && sed -i "s|${mime}=.*$|${mime}=${default_app}|g" ${mimeapps_list_file} || sed -i  "/\[Default Applications\]/a ${mime}=${default_app}" ${mimeapps_list_file} 
done


xdg-desktop-menu forceupdate
