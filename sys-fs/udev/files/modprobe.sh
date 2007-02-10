#!/bin/bash

: ${VERBOSE:=no}
[[ -e /dev/.udev_populate ]] && VERBOSE=yes

source /sbin/functions.sh </dev/console

MODPROBE=/sbin/modprobe
MODLIST=$("${MODPROBE}" -i --show-depends "${@}" | sed "s#^insmod /lib.*/\(.*\)\.ko.*#\1#g" | sed 's|-|_|g')

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

if [[ ${VERBOSE} != no ]]; then
	# print line if not already loaded
	if ! grep -q "^${LAST}[[:space:]]" /proc/modules; then
		einfo "  udev loading module ${LAST}" > /dev/console
	fi
fi

# now do real loading
exec "${MODPROBE}" "${@}"
