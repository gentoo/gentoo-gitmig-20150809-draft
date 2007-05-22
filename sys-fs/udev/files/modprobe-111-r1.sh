#!/bin/sh

# Do not continue for non-modular kernel - Bug #168322
[ ! -f /proc/modules ] && exit 0

if [ -e /dev/.udev_populate ]; then
	# Enable verbose while called from udev-addon-start
	. /dev/.udev_populate

	if [ -c "${CONSOLE}" ]; then
		# redirect stdin/out/err
		exec <${CONSOLE} >${CONSOLE} 2>/${CONSOLE}
	fi
fi

. /etc/init.d/functions.sh

MODPROBE=/sbin/modprobe

# Create a lock file for the current module.
lock_modprobe() {
	[ -e /dev/.udev/ ] || return 0

	MODPROBE_LOCK="/dev/.udev/.lock-modprobe-${MODNAME}"

	retry=20
	while ! mkdir "$MODPROBE_LOCK" 2> /dev/null; do
		if [ $retry -eq 0 ]; then
			 ewarn "Could lock modprobe ${MODNAME}!"
			 return 1
		fi
		sleep 1
		retry=$(($retry - 1))
	done
	return 0
}

unlock_modprobe() {
	[ "$MODPROBE_LOCK" ] || return 0
	rmdir "$MODPROBE_LOCK" || true
}

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

lock_modprobe
# check if loaded
if ! grep -q "^${MODNAME}[[:space:]]" /proc/modules; then
	# now do real loading
	einfo "  udev loading module ${MODNAME}"
	"${MODPROBE}" -q "${@}" >/dev/null 2>/dev/null
fi
unlock_modprobe

