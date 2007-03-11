#!/bin/bash

if [[ -e /dev/.udev_populate ]]; then
	# Enable verbose while called from udev-addon-start
	source /dev/.udev_populate

	if [[ -c ${CONSOLE} ]]; then
		# redirect stdin/out/err
		exec <${CONSOLE} &>${CONSOLE}
	fi
fi

. /etc/init.d/functions.sh

MODPROBE=/sbin/modprobe
MODLIST=$("${MODPROBE}" -q -i --show-depends "${@}" | sed "s#^insmod /lib.*/\(.*\)\.ko.*#\1#g" | sed 's|-|_|g')

[[ -z ${MODLIST} ]] && exit 0
for m in ${MODLIST}; do
	LAST=$m
done

# check for blacklisting
if [[ -f /etc/modprobe.conf ]]; then
	if grep -q '^blacklist.*[[:space:]]'"${LAST}"'\([[:space:]]\|$\)' /etc/modprobe.conf; then
		# module blacklisted
		exit 0
	fi
fi

# check if loaded
if ! grep -q "^${LAST}[[:space:]]" /proc/modules; then
	# now do real loading
	einfo "  udev loading module ${LAST}"
	exec "${MODPROBE}" -q "${@}"
fi

