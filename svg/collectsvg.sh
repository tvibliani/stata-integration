#!/bin/bash
echo "destination=test"
for svgfile in *.svg;do
    echo "cat <<EOF > \${destination}/${svgfile}"
    cat ${svgfile}
    echo "EOF"
    echo
done

