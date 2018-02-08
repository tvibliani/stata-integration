#!/bin/bash

mimeapps_list_file=/usr/share/applications/mimeapps.list

#################################################
# START
# Utility Functions
##

_set_default_app () {
    # Arguments: first one is .desktop file, followed by one or more mime types.
    default_app=$1
    shift
    for mime in $@;do
        grep -q "${mime}" ${mimeapps_list_file} && sed -i "s|${mime}=.*$|${mime}=${default_app}|g" ${mimeapps_list_file} || sed -i  "/\[Default Applications\]/a ${mime}=${default_app}" ${mimeapps_list_file} 
    done

}

##
# Utility Functions
# END
#################################################


####
####
##
##  Main
##
####
####

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

STATA_MIME_TYPES_A=("application/x-stata-do" "application/x-stata-dta")
STATA_MIME_TYPES_B=("application/x-stata-gph" "application/x-stata-smcl" "application/x-stata-stpr" "application/x-stata-stsem")

_set_default_app ${STATA_GUI} ${STATA_MIME_TYPES_B[*]}
_set_default_app ${STATA_CONSOLE} ${STATA_MIME_TYPES_A[*]}


xdg-desktop-menu forceupdate


