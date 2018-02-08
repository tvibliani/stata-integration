#!/bin/bash

mimeapps_list_file=/usr/share/applications/mimeapps.list

#################################################
# START
# Utility Functions
##

function _set_default_app {
    # Arguments: first one is .desktop file, followed by one or more mime types.
    default_app=$1
    shift
    for mime in $@;do
        grep -q "${mime}" ${mimeapps_list_file} && sed -i "s|${mime}=.*$|${mime}=${default_app}|g" ${mimeapps_list_file} || sed -i  "/\[Default Applications\]/a ${mime}=${default_app}" ${mimeapps_list_file} 
    done

}

function install_stata_mimetypes {
    destination=$1
    cat <<EOF > $destination/stata-mimetypes.xml
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="application/x-stata-do">
		<comment>Stata do/ado file</comment>
		<comment xml:lang="de">Stata do/ado Datei</comment>
		<glob pattern="*.do"/>
		<glob pattern="*.ado"/>
		<icon name="application-x-stata-do"/>
  </mime-type>
  <mime-type type="application/x-stata-dta">
		<comment>Stata dataset file</comment>
		<comment xml:lang="de">Stata Datensatz</comment>
		<glob pattern="*.dta"/>
		<icon name="application-x-stata-dta"/>
  </mime-type>
  <mime-type type="application/x-stata-gph">
		<comment>Stata graph file</comment>
		<comment xml:lang="de">Stata Grafik</comment>
		<glob pattern="*.gph"/>
		<icon name="application-x-stata-gph"/>
  </mime-type>
  <mime-type type="application/x-stata-smcl">
		<comment>Stata SMCL file</comment>
		<comment xml:lang="de">Stata SMCL-Datei</comment>
		<glob pattern="*.smcl"/>
		<glob pattern="*.sthlp"/>
		<icon name="application-x-stata-smcl"/>
  </mime-type>
  <mime-type type="application/x-stata-stpr">
		<comment>Stata project file</comment>
		<comment xml:lang="de">Stata Projektdatei</comment>
		<glob pattern="*.stpr"/>
		<icon name="application-x-stata-stpr"/>
  </mime-type>
  <mime-type type="application/x-stata-stsem">
		<comment>Stata SEM file</comment>
		<comment xml:lang="de">Stata SEM-Datei</comment>
		<glob pattern="*.stsem"/>
		<icon name="application-x-stata-stsem"/>
  </mime-type>
</mime-info>

EOF
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
install_stata_mimetypes /usr/share/mime/packages
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


