#!/bin/sh

# Do not continue for non-modular kernel - Bug #168322
[ ! -f /proc/modules ] && exit 0

if [ -e /dev/.udev_populate ]; then
	# Enable verbose while called from udev-addon-start
	source /dev/.udev_populate

	if [ -c "${CONSOLE}" ]; then
		# redirect stdin/out/err
		exec <${CONSOLE} &>${CONSOLE}
	fi
fi

source /sbin/functions.sh

MODPROBE=/sbin/modprobe
MODLIST=$("${MODPROBE}" -q -i --show-depends "${@}" 2>/dev/null \
	| sed -e "s#^insmod /lib.*/\(.*\)\.ko.*#\1#g" -e 's|-|_|g')

# exit if you have no modules to load
[ -z "${MODLIST}" ] && exit 0
for m in ${MODLIST}; do
	MODNAME=$m
done

# check for blacklisting
if [ -f /etc/modprobe.conf ]; then
	if grep -q '^blacklist.*[[:space:]]'"${MODNAME}"'\([[:space:]]\|$\)' /etc/modprobe.conf; then
		# module blacklisted
		exit 0
	fi
fi

# check if loaded
if ! grep -q "^${MODNAME}[[:space:]]" /proc/modules; then
	# now do real loading
	einfo "  udev loading module ${MODNAME}"
	exec "${MODPROBE}" -q "${@}" &>/dev/null
fi

