#!/bin/sh
#
# Written by Arcady Genkin <agenkin@thpoon.com>
#
# Run this script as root.

mk_node () {
    local dev="$1"
    local major="$2"
    local minor="$3"
    local owner=root
    local group=video
    local mode=0660

    rm -f "${dev}"
    if /bin/mknod -m "${mode}" "${dev}" c "$major" "${minor}"
    then
        chown "${owner}" "${dev}"
        chgrp "${group}" "${dev}"
    else
        echo "Could not create ${dev}." 1>&2
    fi
}

mk_dev_nodes () {
    local nv_major=195
    
    for i in 0 1 2 3
    do
        mk_node "/dev/nvidia${i}" "${nv_major}" "${i}"
    done

    mk_node "/dev/nvidiactl" "${nv_major}" 255
}

mk_dev_nodes

echo ""
echo "*** You might want to add yourself to 'video' group."
echo ""
