# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

populate_udev() {
	# populate /dev with devices already found by the kernel

	# tell modprobe.sh to be verbose to $CONSOLE
	echo CONSOLE=${CONSOLE} > /dev/.udev_populate

	if get_bootparam "nocoldplug" ; then
		RC_COLDPLUG="no"
		ewarn "Skipping udev coldplug as requested in kernel cmdline"
	fi

	if [ $(get_KV) -gt $(KV_to_int '2.6.14') ] ; then
		ebegin "Populating /dev with existing devices through uevents"
		local opts=
		[ "${RC_COLDPLUG}" != "yes" ] && opts="--attr-match=dev"
		/sbin/udevtrigger ${opts}
		eend $?
	else
		ebegin "Populating /dev with existing devices with udevstart"
		/sbin/udevstart
		eend $?
	fi

	# loop until everything is finished
	# there's gotta be a better way...
	ebegin "Letting udev process events"
	/sbin/udevsettle --timeout=60
	eend $?

	rm -f /dev/.udev_populate
	return 0
}

seed_dev() {
	# Seed /dev with some things that we know we need
	ebegin "Seeding /dev with needed nodes"

	# creating /dev/console and /dev/tty1 to be able to write
	# to $CONSOLE with/without bootsplash before udevd creates it
	[ ! -c /dev/console ] && mknod /dev/console c 5 1
	[ ! -c /dev/tty1 ] && mknod /dev/tty1 c 4 1
	
	# udevd will dup its stdin/stdout/stderr to /dev/null
	# and we do not want a file which gets buffered in ram
	[ ! -c /dev/null ] && mknod /dev/null c 1 3

	# copy over any persistant things
	if [ -d /lib/udev/devices ] ; then
		cp --preserve=all --recursive --update /lib/udev/devices/* /dev 2>/dev/null
	fi

	# Not provided by sysfs but needed
	ln -snf /proc/self/fd /dev/fd
	ln -snf fd/0 /dev/stdin
	ln -snf fd/1 /dev/stdout
	ln -snf fd/2 /dev/stderr
	[ -e /proc/kcore ] && ln -snf /proc/kcore /dev/core

	# Create problematic directories
	mkdir -p /dev/pts /dev/shm
	eend 0
}

unpack_device_tarball() {
	# Actually get udev rolling
	if [ "${RC_DEVICE_TARBALL}" = "yes" ] && \
	    [ -s /lib/udev/state/devices.tar.bz2 ] ; then
		ebegin "Populating /dev with saved device nodes"
		try tar -jxpf /lib/udev/state/devices.tar.bz2 -C /dev
		eend $?
	fi
}

main() {
	# Setup temporary storage for /dev
	ebegin "Mounting /dev for udev"
	if [ "${RC_USE_FSTAB}" = "yes" ] ; then
		mntcmd=$(get_mount_fstab /dev)
	else
		unset mntcmd
	fi
	if [ -n "${mntcmd}" ] ; then
		try mount -n ${mntcmd}
	else
		if grep -Eq "[[:space:]]+tmpfs$" /proc/filesystems ; then
			mntcmd="tmpfs"
		else
			mntcmd="ramfs"
		fi
		# many video drivers require exec access in /dev #92921
		try mount -n -t "${mntcmd}" -o exec,nosuid,mode=0755 udev /dev
	fi
	eend $?

	# Create a file so that our rc system knows it's still in sysinit.
	# Existance means init scripts will not directly run.
	# rc will remove the file when done with sysinit.
	touch /dev/.rcsysinit

	# Selinux lovin; /selinux should be mounted by selinux-patched init
	if [ -x /sbin/restorecon ] && [ -c /selinux/null ] ; then
		restorecon /dev > /selinux/null
	fi

	unpack_device_tarball
	seed_dev

	# Setup hotplugging (if possible)
	if [ -e /proc/sys/kernel/hotplug ] ; then
		ebegin "Setting up proper hotplug agent"
		eindent
		if [ $(get_KV) -gt $(KV_to_int '2.6.14') ] ; then
			einfo "Using netlink for hotplug events..."
			echo "" > /proc/sys/kernel/hotplug
		else
			einfo "Setting /sbin/udevsend as hotplug agent ..."
			echo "/sbin/udevsend" > /proc/sys/kernel/hotplug
		fi
		eoutdent
		eend 0
	fi

	ebegin "Starting udevd"
	/sbin/udevd --daemon
	eend $?

	populate_udev

	# Create nodes that udev can't
	ebegin "Finalizing udev configuration"
	[ -x /sbin/lvm ] && \
		/sbin/lvm vgscan -P --mknodes --ignorelockingfailure &>/dev/null
	# Running evms_activate on a LiveCD causes lots of headaches
	[ -z "${CDBOOT}" ] && [ -x /sbin/evms_activate ] && \
		/sbin/evms_activate -q &>/dev/null
	eend 0
}

main

# vim:ts=4
