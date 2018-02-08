#!/bin/bash

mimeapps_list_file=/usr/share/applications/mimeapps.list

#################################################
# START
# Utility Functions
##

function _set_default_app {
    # Arguments: first one is .desktop file, followed by one or more mime types.
    default_app=$1
    echo "> Seting '${default_app}' as a default application for the following mime type(s):"
    echo "  (editing: ${mimeapps_list_file})"
    shift
    for mime in $@;do
        echo -ne "  - \"${mime}\"... \t" && 
        grep -q "${mime}" ${mimeapps_list_file} && sed -i "s|${mime}=.*$|${mime}=${default_app}|g" ${mimeapps_list_file} || sed -i  "/\[Default Applications\]/a ${mime}=${default_app}" ${mimeapps_list_file} && echo "ok" || echo "fail"
    done

}

function install_stata_mimetypes {
    destination="$1/stata-mimetypes.xml"
    echo -ne "> Installing mime info at '${destination}'...\t"
    cat <<EOF > ${destination}  && echo "ok" || echo "fail"
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

function install_stata_icons {
	# Generate SVG icons for Stata 15
	destination=$1/application-x-stata-do.svg
    echo "> Installing icon images for Stata files and menu entries:"
    echo -ne "  - '${destination}'... \t " &&
	cat <<EOF > ${destination}  && echo "ok" || echo "fail"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px" height="256px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">  <image id="image0" width="256" height="256" x="0" y="0"
    xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAABGdBTUEAALGPC/xhBQAAACBjSFJN
AAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACQFBMVEUAAABiiqdiiqdiiqdi
iqeqv8+VsMNiiqdiiqdiiqdiiqdiiqdiiqeqv898nbWpvs6kt8Zqg5ejtcOjtcTI1d9iiqfI1d//
///J1d/O2uPc5Orx9PfY4ej7/PzP2uLz8/TCy9L29fW7vcC+xczF0dr39va4t7eurKyvra2wrq+w
r6+xsLCysLGzsrK0s7O1s7O0s7S1tLW3tbW3tra5uLhOaHxOaX1PaX5Pan9Pan5Pa4BQa4BQbIFR
bIJRbYJRbYNRboNRboRSboRSb4VScIZTcIZTcIdTcYdTcYj29va7urq6uLm7ubpSb4ZTcoi9vL28
urq8u7tUcolUc4m/vr6+vb1Uc4r39/fBwMDAv79Vc4pVdIvDwcLBv8DBwcFVdIzFxMTCwcLDwsNV
dYxVdY34+PjHxsbEw8NWdY1Wdo5Wdo3JycnGxcVWd4/LysvIx8dXd45Xd4/NzMzJx8hXd5D5+fnO
zs7KyclXeJBYeJBYeZHQz9DMy8tXeJHS0dHOzc1YeZJYepL6+vrU09NYepNZepPW1dXQz89giKRZ
e5Rhh6RafJVZfJVafJZhiKRafZdafZZafpdbfZdbfphhiKVbfpdbfplbf5lcf5lcgJpcgJtcgZth
iaVdgZtdgZxdgpxdgp1eg55egp1dg55iiaZehJ9eg59ehKBfhKBfhaBfhaFhiaZfhqFghqJfhqJi
iqZgh6Ngh6SBobmrwdDL2OLg6O3V4Ohskq3A0Nz19/mWscTq7/OhucqMqb53mrO2yNbwowcNAAAA
FXRSTlMAQ6Tl/dUCFLQR2LPk1gTa3gXg4AGlD+K4AAAAAWJLR0QXC9aYjwAAAAlwSFlzAAAOwwAA
DsMBx2+oZAAAAAd0SU1FB+ICBhUIK7Z7DkYAAAdYSURBVHja7dr7WxRVGAdwQEpBu3c43e9ZWXYx
UjOizMpLpUWkJmnesEzBJCFDS7JMLgEWW4oSga6K3AT2Diz9a81eZnZ25iww8+zMefec9/3NfQ7u
8/2c856ZnTN5eVhYWFhYWFhY86j8ggWFxOW65VbeqbVauMjt8LEqASNQVMwjPykBI7CYS34FAIhA
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" />
</svg>
EOF
    destination=$1/application-x-stata-dta.svg
    echo -ne "  - '${destination}'...\t "
    cat <<EOF > ${destination}  && echo "ok" || echo "fail"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px" height="256px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">  <image id="image0" width="256" height="256" x="0" y="0"
    xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAABGdBTUEAALGPC/xhBQAAACBjSFJN
AAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACQFBMVEUAAABiiqdiiqdiiqdi
iqeqv8+VsMNiiqdiiqdiiqdiiqdiiqdiiqeqv898nbWpvs6kt8Zqg5ejtcOjtcTI1d9iiqfI1d//
///J1d/O2uPc5Orx9PfY4ej7/PzP2uLz8/TCy9L29fW7vcC+xczF0dr39va4t7eurKyvra2wrq+w
r6+xsLCysLGzsrK0s7O1s7O0s7S1tLW3tbW3tra5uLhOaHxOaX1PaX5Pan9Pan5Pa4BQa4BQbIFR
bIJRbYJRbYNRboNRboRSboRSb4VScIZTcIZTcIdTcYdTcYj29va7urq6uLm7ubpSb4ZTcoi9vL28
urq8u7tUcolUc4m/vr6+vb1Uc4r39/fBwMDAv79Vc4pVdIvDwcLBv8DBwcFVdIzFxMTCwcLDwsNV
dYxVdY34+PjHxsbEw8NWdY1Wdo5Wdo3JycnGxcVWd4/LysvIx8dXd45Xd4/NzMzJx8hXd5D5+fnO
zs7KyclXeJBYeJBYeZHQz9DMy8tXeJHS0dHOzc1YeZJYepL6+vrU09NYepNZepPW1dXQz89giKRZ
e5Rhh6RafJVZfJVafJZhiKRafZdafZZafpdbfZdbfphhiKVbfpdbfplbf5lcf5lcgJpcgJtcgZth
iaVdgZtdgZxdgpxdgp1eg55egp1dg55iiaZehJ9eg59ehKBfhKBfhaBfhaFhiaZfhqFghqJfhqJi
iqZgh6Ngh6R3mrPA0Nz19/nq7/OrwdBskq3g6O3V4OiWscShucqBobmMqb62yNbL2OI8I4R/AAAA
FXRSTlMAQ6Tl/dUCFLQR2LPk1gTa3gXg4AGlD+K4AAAAAWJLR0QXC9aYjwAAAAlwSFlzAAAOwwAA
DsMBx2+oZAAAAAd0SU1FB+ICBhULFCswcLgAAAfbSURBVHja7dr7Y9NUFAfwbUx5+vYuvt+iovjA
CYiITlQeKigiIAjyGoowEAREQJkosocb6KowmHODAmOwMZo+13X910yb3DRNb9oE29yT3HN+gXZn
jO8n9yQ36aqqsLCwsLCwsLBsVHXNhFrict1yK+/Uek2c5Hb4TNWBEZg8hUd+UgdGYCqX/AoAEIFq
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" />
</svg>
EOF

    destination=$1/application-x-stata-gph.svg
    echo -ne "  - '${destination}'...\t "
    cat <<EOF > ${destination}  && echo "ok" || echo "fail"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px" height="256px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">  <image id="image0" width="256" height="256" x="0" y="0"
    xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAABGdBTUEAALGPC/xhBQAAACBjSFJN
AAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACQFBMVEUAAABiiqdiiqdiiqdi
iqeqv8+VsMNiiqdiiqdiiqdiiqdiiqdiiqeqv898nbWpvs6kt8Zqg5ejtcOjtcTI1d9iiqfI1d//
///J1d/O2uPc5Orx9PfY4ej7/PzP2uLz8/TCy9L29fW7vcC+xczF0dr39va4t7eurKyvra2wrq+w
r6+xsLCysLGzsrK0s7O1s7O0s7S1tLW3tbW3tra5uLhOaHxOaX1PaX5Pan9Pan5Pa4BQa4BQbIFR
bIJRbYJRbYNRboNRboRSboRSb4VScIZTcIZTcIdTcYdTcYj29va7urq6uLm7ubpSb4ZTcoi9vL28
urq8u7tUcolUc4m/vr6+vb1Uc4r39/fBwMDAv79Vc4pVdIvDwcLBv8DBwcFVdIzFxMTCwcLDwsNV
dYxVdY34+PjHxsbEw8NWdY1Wdo5Wdo3JycnGxcVWd4/LysvIx8dXd45Xd4/NzMzJx8hXd5D5+fnO
zs7KyclXeJBYeJBYeZHQz9DMy8tXeJHS0dHOzc1YeZJYepL6+vrU09NYepNZepPW1dXQz89giKRZ
e5Rhh6RafJVZfJVafJZhiKRafZdafZZafpdbfZdbfphhiKVbfpdbfplbf5lcf5lcgJpcgJtcgZth
iaVdgZtdgZxdgpxdgp1eg55egp1dg55iiaZehJ9eg59ehKBfhKBfhaBfhaFhiaZfhqFghqJfhqJi
iqZgh6Ngh6SBobmrwdDL2OLg6O3q7/PV4Oihucp3mrNskq3A0Nz19/mMqb6WscS2yNbLaOR4AAAA
FXRSTlMAQ6Tl/dUCFLQR2LPk1gTa3gXg4AGlD+K4AAAAAWJLR0QXC9aYjwAAAAlwSFlzAAAOwwAA
DsMBx2+oZAAAAAd0SU1FB+ICBhUMDpkTHwUAAAfDSURBVHja7dr5e9REGAfwtlQ5vZ2O9y0qigdW
QEQQUTlUUERAEOQqilAQBERAqSjSwxa0q1CotYUFSqGlNHs1Tdt/zWR3J5tMkm7zPJvMZOZ9fyMd
9pnvZ2aSyVFWBgUFBQUFBQU1jiqvmFCJQq7bbmed2qyJk8IOb1QVNwKTp7DIj6q4EZjKJL8OwIlA
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
MjoxNC0wNzowMB+qQ5oAAAAASUVORK5CYII=" />
</svg>
EOF

    destination=$1/application-x-stata-smcl.svg
    echo -ne "  - '${destination}'...\t "
    cat <<EOF > ${destination}  && echo "ok" || echo "fail"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px" height="256px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">  <image id="image0" width="256" height="256" x="0" y="0"
    xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAABGdBTUEAALGPC/xhBQAAACBjSFJN
AAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACQFBMVEUAAABiiqdiiqdiiqdi
iqeqv8+VsMNiiqdiiqdiiqdiiqdiiqdiiqeqv898nbWpvs6kt8Zqg5ejtcOjtcTI1d9iiqfI1d//
///J1d/O2uPc5Orx9PfY4ej7/PzP2uLz8/TCy9L29fW7vcC+xczF0dr39va4t7eurKyvra2wrq+w
r6+xsLCysLGzsrK0s7O1s7O0s7S1tLW3tbW3tra5uLhOaHxOaX1PaX5Pan9Pan5Pa4BQa4BQbIFR
bIJRbYJRbYNRboNRboRSboRSb4VScIZTcIZTcIdTcYdTcYj29va7urq6uLm7ubpSb4ZTcoi9vL28
urq8u7tUcolUc4m/vr6+vb1Uc4r39/fBwMDAv79Vc4pVdIvDwcLBv8DBwcFVdIzFxMTCwcLDwsNV
dYxVdY34+PjHxsbEw8NWdY1Wdo5Wdo3JycnGxcVWd4/LysvIx8dXd45Xd4/NzMzJx8hXd5D5+fnO
zs7KyclXeJBYeJBYeZHQz9DMy8tXeJHS0dHOzc1YeZJYepL6+vrU09NYepNZepPW1dXQz89giKRZ
e5Rhh6RafJVZfJVafJZhiKRafZdafZZafpdbfZdbfphhiKVbfpdbfplbf5lcf5lcgJpcgJtcgZth
iaVdgZtdgZxdgpxdgp1eg55egp1dg55iiaZehJ9eg59ehKBfhKBfhaBfhaFhiaZfhqFghqJfhqJi
iqZgh6Ngh6SWscS2yNbV4Oj19/nA0NyrwdB3mrOBobng6O1skq2hucqMqb7L2OLq7/OCSumrAAAA
FXRSTlMAQ6Tl/dUCFLQR2LPk1gTa3gXg4AGlD+K4AAAAAWJLR0QXC9aYjwAAAAlwSFlzAAAOwwAA
DsMBx2+oZAAAAAd0SU1FB+ICBhUNDoAILkQAAAlpSURBVHja7dr3exRFGAfwJESpdidj772XqKiI
YqNYUERRsaAYFRFUBFQsxIKmmKAmKpEYEzwwBBLD3Za7vfavuXe7szM7O3fkfO525nbf9xee29ss
+/3MvFuvpQUKCgoKCgoKag7V2javHYVcp5wqO7VX8xeEHb5UHcoILFwkIz/qUEZgsZT8NoAiAq1y
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" />
</svg>
EOF

    destination=$1/application-x-stata-stpr.svg
    echo -ne "  - '${destination}'...\t "
    cat <<EOF > ${destination}  && echo "ok" || echo "fail" 
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px" height="256px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">  <image id="image0" width="256" height="256" x="0" y="0"
    xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAABGdBTUEAALGPC/xhBQAAACBjSFJN
AAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACQFBMVEUAAABiiqdiiqdiiqdi
iqeqv8+VsMNiiqdiiqdiiqdiiqdiiqdiiqeqv898nbWpvs6kt8Zqg5ejtcOjtcTI1d9iiqfI1d//
///J1d/O2uPc5Orx9PfY4ej7/PzP2uLz8/TCy9L29fW7vcC+xczF0dr39va4t7eurKyvra2wrq+w
r6+xsLCysLGzsrK0s7O1s7O0s7S1tLW3tbW3tra5uLhOaHxOaX1PaX5Pan9Pan5Pa4BQa4BQbIFR
bIJRbYJRbYNRboNRboRSboRSb4VScIZTcIZTcIdTcYdTcYj29va7urq6uLm7ubpSb4ZTcoi9vL28
urq8u7tUcolUc4m/vr6+vb1Uc4r39/fBwMDAv79Vc4pVdIvDwcLBv8DBwcFVdIzFxMTCwcLDwsNV
dYxVdY34+PjHxsbEw8NWdY1Wdo5Wdo3JycnGxcVWd4/LysvIx8dXd45Xd4/NzMzJx8hXd5D5+fnO
zs7KyclXeJBYeJBYeZHQz9DMy8tXeJHS0dHOzc1YeZJYepL6+vrU09NYepNZepPW1dXQz89giKRZ
e5Rhh6RafJVZfJVafJZhiKRafZdafZZafpdbfZdbfphhiKVbfpdbfplbf5lcf5lcgJpcgJtcgZth
iaVdgZtdgZxdgpxdgp1eg55egp1dg55iiaZehJ9eg59ehKBfhKBfhaBfhaFhiaZfhqFghqJfhqJi
iqZgh6Ngh6SWscS2yNbV4Oj19/nA0NyrwdB3mrNskq3g6O2hucrq7/PL2OKBobmMqb6Cb+TEAAAA
FXRSTlMAQ6Tl/dUCFLQR2LPk1gTa3gXg4AGlD+K4AAAAAWJLR0QXC9aYjwAAAAlwSFlzAAAOwwAA
DsMBx2+oZAAAAAd0SU1FB+ICBhUPFE9ctbwAAAhoSURBVHja7dr5e9REGAfwtlQ5vZ3G+xYVxQMr
ICKIqBwqKCIgCHIVRSgIAiKgVBTpYQvaKhRqbWGBUmgpu8mme/ZfM3tMNsdkNnnIzgzJ+/7W7Wyf
fD+ZdzJJWlUFBQUFBQUFBeWiqmvG1SLGddvtvFPrNX4C6/C5qhNGYOIkHvlRnTACk7nk1wAEEajm
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
NzowMIe2exMAAAAASUVORK5CYII=" />
</svg>
EOF

    destination=$1/application-x-stata-stsem.svg
    echo -ne "  - '${destination}'... "
    cat <<EOF > ${destination}  && echo "ok" || echo "fail"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px" height="256px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">  <image id="image0" width="256" height="256" x="0" y="0"
    xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAABGdBTUEAALGPC/xhBQAAACBjSFJN
AAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACQFBMVEUAAABiiqdiiqdiiqdi
iqeqv8+VsMNiiqdiiqdiiqdiiqdiiqdiiqeqv898nbWpvs6kt8Zqg5ejtcOjtcTI1d9iiqfI1d//
///J1d/O2uPc5Orx9PfY4ej7/PzP2uLz8/TCy9L29fW7vcC+xczF0dr39va4t7eurKyvra2wrq+w
r6+xsLCysLGzsrK0s7O1s7O0s7S1tLW3tbW3tra5uLhOaHxOaX1PaX5Pan9Pan5Pa4BQa4BQbIFR
bIJRbYJRbYNRboNRboRSboRSb4VScIZTcIZTcIdTcYdTcYj29va7urq6uLm7ubpSb4ZTcoi9vL28
urq8u7tUcolUc4m/vr6+vb1Uc4r39/fBwMDAv79Vc4pVdIvDwcLBv8DBwcFVdIzFxMTCwcLDwsNV
dYxVdY34+PjHxsbEw8NWdY1Wdo5Wdo3JycnGxcVWd4/LysvIx8dXd45Xd4/NzMzJx8hXd5D5+fnO
zs7KyclXeJBYeJBYeZHQz9DMy8tXeJHS0dHOzc1YeZJYepL6+vrU09NYepNZepPW1dXQz89giKRZ
e5Rhh6RafJVZfJVafJZhiKRafZdafZZafpdbfZdbfphhiKVbfpdbfplbf5lcf5lcgJpcgJtcgZth
iaVdgZtdgZxdgpxdgp1eg55egp1dg55iiaZehJ9eg59ehKBfhKBfhaBfhaFhiaZfhqFghqJfhqJi
iqZgh6Ngh6SWscS2yNbV4Oj19/nA0NyrwdB3mrNskq3g6O2hucqMqb7L2OKBobnq7/PyrRCsAAAA
FXRSTlMAQ6Tl/dUCFLQR2LPk1gTa3gXg4AGlD+K4AAAAAWJLR0QXC9aYjwAAAAlwSFlzAAAOwwAA
DsMBx2+oZAAAAAd0SU1FB+ICBhUQDeZtE+IAAAjrSURBVHja7dr5e9REGAfwtlQ5vZ2O9y0qigdW
QEQUUTlUUERAEOQqilyCgAgqFUV62IK2CoVaW1igFFrK7mbTzV7/msluJpkk093keXYzs8n7/pjr
6fczZ7KtqYGCgoKCgoKCclG1dRPqkc91y628Uxs1cZLf4bVqEEZg8hQe+VGDMAJTueRXAQQRqOWT
XwMQQ6COI4AQAtN4Aogg4Pv6ZwEQQIBTfgLAX4A3AHcB7gC8BfgDcBYQAICvgAgAXAWEAOApIAYA
RwFBAPgJiALATUAYAF4C4gBwEhAIgI+ASABcBIQC4CEgFgAHAcEA/BcQDcB3AeEA/BYQD8BnAQEB
/BUQEcBXASEB/BQQE8BHAUEB/BMQFcA3AWEB/BIQF8AnAYEB/BEQGcAXAaEB/BAQG8AHgXIFwiXK
fp1LgMoLiA5QcQHhASotID5Aw223hxyg4Y5KClQDQEUFqgKgkgLVAVBBAV4A94kiwAvgfo8AFRPg
BfCAV4BKCfACeNAzQIUEeAHghwQR4Abw8CPeBe68K0AA+NHHvAvcXf4+wA8AP/7Ek095Fbjn3gAB
4KenP/PsczNmPP/CzJkvvvTyK7NmvdrY+Nrs2XPmzH197rx5b8yfP//NBQsWvPX2woUL31m06N33
3l+8eEmQegDGS5fR6ac3Nn7woRqflf6jQvwly4MFgJeusKRf9vEnpPFZ6ZcsX/lpwADw0lV0+hUr
PqMa35l+5erVQQPAa9aq8Un6Vas+Zw58kn7duvWBA8BrvijE19JvWLuROfBJ+vXrvwweAF6zSW/8
DRs3b97CHPgr9fRbt20NIABu2l5ofDX+lq+YA78Qf9vWr3d8E0QA3LRTT79p0y7mwC80vhp/x+5A
AuCmPYX0u7bvZQ58Pf2O3d/uCyYAbtqfT7/3u53Wxrel33fgQEAB8MFDWvqd3+9xdH06/eEfjgQV
AB88qqbf8+OPzK5P0v90JLgA+ODPavz9x5gDX4uvpW9u/iW4APj4r/uPHTrEHPiFxm9ubv7tRIAB
8PHfT548yhz4hcZX458QF6Ac1bJ7nIFP0re2tgYaALUdZg98kr61vT3YAKjtCHPgk/R/tHcEHAB1
Nu9md/18+o6OU0EHUAUY6fX4p06f+jPwAKjzBDt9Pv5fXcEHQN2tWnxW+r+7usIAgLrb7QOfpO/6
54zvAGXY4Hi+rrvDNvBJ+rNnwwGAuk9bBz5J39PTEw4A1N1l7/r59D0950ICoArYun4+/bnz58MC
gHrP2tLn4//bFxoA1NvjTN/X9194AFSBM/b0/X39IQJAveft6fsHLoQJAPX2kfh6+gsXB0IFgCL9
dONfHFArXAAocoFqfK0uhQwARQbM9JcHLl2+HDYAVYBKf+XSYOgAUOSKmX5w8Gr4AFBk0Eh/dWgo
hADo2lUtvpZ+KJwA6NqQHv/69eFQAqBr1/X4wyPhBEA3RrT0wyMjIe0BqkA+/fDwaFgB0I1RNb1a
oQVAkdHRcAOgyE01/80QA6BIy82WljADoEhnW1uoARDq7gw5AOoOOwACAAAAAADwFUC0AgAAAAAA
AAAAAAD/APza4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
PwDRCgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD8AIjG4hLGUjwhj4UQIClL
1E99Ssp6MiFZfwpU0rbb0xkJK7LTNINxPIXcFzeAtC0hVpJUfsX5a2jWcnvKeZNWicLhhPgAKWfC
eNGzOGNpaIPN8tQYORwTHYCVkGrjDC7qg5DZQ+juPmZenXT3d/ACGJNYAOYwj5fqAeZhurenWM8S
EoDVwnSrsQDoSFnzsMR+rOzq7+AFYHZVKSHLmZxj3DoBJMvMHqXORI2jSeqo60mAC4Bs9N9Co2dj
OeufTADSpLLjPMASlWaJu/gz+AGQfLlSF4x3nh5C5kMSdI8RGiBXaqCWArBsE4zeYZlZ3S4DXABK
DtRSAJbpgTBmLUfdLgNcAaTsOBeUALBGJXuhGJNFSACjB0syu6eWACCznd7n9TepnOWg22WACwA9
h2VSDIMSAGQR0Nu8sELqa6sS97YMcAGwbYQVx9uwYxlkAsb1npChVWKyt2WAC4CxDJjLtjWicyMU
p/uJPoQSZDKh78kSXZfLAB+ANHYmpCdExlaY7tLGPKd3BW0zmCQNT57tchngA8B8G6Q2u6x3AROI
LAJR8piE+cSEsSF2uQxwAkDZXDGB4i9DUePImDneM8YzyAwpNoDaZE4Co5FZAOZEKZtDXzFulIyR
720Z4AegtqT9w5/xNzMAqAbNmO0eIyf1XqFYTwsOgLT3QOa23gGQo0e0YnJlSe6EOfBJB3G3DHAG
UGssZvYD0szFN0L0xWQzmDMFzSmiOgDUFczYGZIxUBSALAL5TkE+A+sdRTuUps9XBYC5MZLcAFha
2LqeJhw9pEoAyLAliYsCkIvzE0bSAlD4PCZ5WQaqECBjOWmZLy2HpCoCIEsBebUvCqBQ4936eVD/
ck4+jblaBvgAJGVZpvb+aVuC4gDWCZP+OCJbTVwtA1wAsvlRqhCDlGRL4HwdTputaZ/kqQ3lGPsK
8QCMcZtLyHKCSpC0X2CW8T6cssUzvwWTAUQ6haufSLkA4HHKWLhY7wJkUrd38KjzdtsdVQMgGf2c
BUD2yeTcmONpxpgnfUpYgBwbwJwWmQBp6znjYrIsSo7bhQWIsvJJ1KQtsy7Qm1x/ATR/LCaTQsJ+
u+Lmb+ECgKLOn8cV+pNYktFHyAjXf1qnuAobA8n8YJAsXBJ186fwAVA3AtaIOdu/9Tj+R4h6H86q
fV6J2h4mJegvy45LhAPQWjIlx/ODNReXs67vKnvxAxCkAAAAAAAAAAAAAAAAAAAAAAAAAAAAylD1
vBN5q/qyA0zjHclbTSs7QB3vSN6qruwAtbwjeavasgPUTOWdyUtNLX/+mslTeKdyX1MmVwCgZuIk
3rnc1qSJlcivVm3dBOFXw/oJdRUY/1BQUFBQUFBBrP8BL2NrQLvqLWYAAAAldEVYdGRhdGU6Y3Jl
YXRlADIwMTgtMDItMDZUMjE6MTY6MTMtMDc6MDCiu2XSAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE4
LTAyLTA2VDIxOjE2OjEzLTA3OjAw0+bdbgAAAABJRU5ErkJggg==" />
</svg>
EOF

    destination=$1/stata15.svg
    echo -ne "  - '${destination}'... \t "
    cat <<EOF > ${destination}  && echo "ok" || echo "fail"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px" height="256px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">  <image id="image0" width="256" height="256" x="0" y="0"
    xlink:href="data:image/png;base64,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
RU5ErkJggg==" />
</svg>
EOF

    destination=$1/stata-console15.svg
    echo -ne "  - '${destination}'... \t"
    cat <<EOF > ${destination}  && echo "ok" || echo "fail"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px" height="256px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">  <image id="image0" width="256" height="256" x="0" y="0"
    xlink:href="data:image/png;base64,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" />
</svg>
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
echo
echo "Integrate Stata/IC 15 (add menu entries and file associations)"
echo
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
install_stata_icons /usr/share/icons/gnome/scalable/mimetypes
gtk-update-icon-cache /usr/share/icons/gnome -f

##
# Create menu entries for GUI and Console versions of the Stata-IC 15
##
VERSION=15
FLAVOR=IC
STATA_GUI="stata${VERSION}.desktop"
STATA_GUI_EXECUTABLE=/usr/local/bin/xstata
STATA_CONSOLE="stata${VERSION}-console.desktop"
STATA_CONSOLE_EXECUTABLE=/usr/local/stata15/stata

echo "> Installing menu entries:"
echo -ne "  - /usr/share/applications/${STATA_GUI}...\t"
cat <<EOF > /usr/share/applications/${STATA_GUI} && echo "ok" || echo "fail"
[Desktop Entry]
Encoding=UTF-8
Name=Stata-${FLAVOR} ${VERSION}
Version=1.0
GenericName=Stata
Comment=Start-${FLAVOR} ${VERSION} (GUI mode)
Exec=${STATA_GUI_EXECUTABLE} -q %F
Icon=stata${VERSION}
Terminal=false
Type=Application
MimeType=application/x-stata-dta;application/x-stata-do;application/x-stata-smcl;application/x-stata-stpr;application/x-stata-gph;application/x-stata-stsem;
Categories=Office;Education;Science;Application;GTK;GNOME;
StartupNotify=true
Actions=doedit;use;view;graphuse;projmanag;semopen;


[Desktop Action doedit]
Name=Start Stata and open do-file editor
Exec=${STATA_GUI_EXECUTABLE} -q doedit "%f"

[Desktop Action use]
Name=Start Stata and use file
Exec=${STATA_GUI_EXECUTABLE} -q use "%f"

[Desktop Action view]
Name=Start Stata and open viewer
Exec=${STATA_GUI_EXECUTABLE} -q view "%f"

[Desktop Action graphuse]
Name=Start Stata and open graph editor
Exec=${STATA_GUI_EXECUTABLE} -q graph use "%f"

[Desktop Action semopen]
Name=Start Stata and open structural equation model builder
Exec=${STATA_GUI_EXECUTABLE} -q sembuilder "%f"

[Desktop Action projmanag]
Name=Start Stata and open project manager
Exec=${STATA_GUI_EXECUTABLE} -q projmanag "%f"

EOF
echo -ne "  - /usr/share/applications/${STATA_CONSOLE}...\t"
cat <<EOF > /usr/share/applications/${STATA_CONSOLE} && echo "ok" || echo "fail"
[Desktop Entry]
Encoding=UTF-8
Name=Stata-${FLAVOR} (console) ${VERSION}
Version=1.0
GenericName=Stata (console)
Comment=Start-${FLAVOR} ${VERSION} (console mode)
Exec=${STATA_CONSOLE_EXECUTABLE} -q %F
Icon=stata-console${VERSION}
Terminal=true
Type=Application
MimeType=application/x-stata-dta;application/x-stata-do;
Categories=Office;Education;Science;Application;GTK;GNOME;
StartupNotify=true
Actions=doedit;use;


[Desktop Action doedit]
Name=Open Stata with do-file editor
Exec=${STATA_CONSOLE_EXECUTABLE} -q doedit "%f"

[Desktop Action use]
Name=Open Stata and use file
Exec=${STATA_CONSOLE_EXECUTABLE} -q use "%f"

EOF



##
# Set Stata (GUI version) as default application for all stata files
##

STATA_MIME_TYPES_A=("application/x-stata-do" "application/x-stata-dta")
STATA_MIME_TYPES_B=("application/x-stata-gph" "application/x-stata-smcl" "application/x-stata-stpr" "application/x-stata-stsem")

_set_default_app ${STATA_GUI} ${STATA_MIME_TYPES_B[*]}
_set_default_app ${STATA_CONSOLE} ${STATA_MIME_TYPES_A[*]}


xdg-desktop-menu forceupdate


