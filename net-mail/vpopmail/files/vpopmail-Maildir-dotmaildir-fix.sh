#!/bin/bash
OLDNAME='Maildir'
NEWNAME='.maildir'
SEARCHPATH=/var/vpopmail/domains/

if [ "${1}" == '--revert' ]; then
    SEARCHNAME="${NEWNAME}"
    REPLACENAME="${OLDNAME}"
else
    SEARCHNAME="${OLDNAME}"
    REPLACENAME="${NEWNAME}"
fi

echo "Doing '${SEARCHNAME}' '${REPLACENAME}' changeover"
for i in `find ${SEARCHPATH} -name "${SEARCHNAME}" -maxdepth 3 -mindepth 3 -type d`; do
    foundname=${i}
    todoname=${foundname/${SEARCHNAME}/${REPLACENAME}}
    base="`dirname $i`"
    echo "Fixing `echo $base | sed -e "s|${SEARCHPATH}||g"`"
    chmod +t $base
    if [ -L ${todoname} ]; then
        echo Removing symlink "${todoname}"
        rm ${todoname}
    fi
    if [ -e ${todoname} ]; then
        echo "Error! Cannot move ${i} as destination exists!"
        continue
    fi
    mv "${foundname}" "${todoname}"
    ln -s "${todoname}" "${foundname}"
    chown vpopmail:vpopmail "${foundname}"
    chmod -t $base
done;
