# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

[ -e /etc/conf.d/udev ] && . /etc/conf.d/udev

compat_volume_nodes()
{
	# Only do this for baselayout-1*
	if [ ! -e /lib/librc.so ]; then

		# Create nodes that udev can't
		[ -x /sbin/lvm ] && \
			/sbin/lvm vgscan -P --mknodes --ignorelockingfailure &>/dev/null
		# Running evms_activate on a LiveCD causes lots of headaches
		[ -z "${CDBOOT}" -a -x /sbin/evms_activate ] && \
			/sbin/evms_activate -q &>/dev/null
	fi
}

start_initd()
{
	(
		called_from_addon=1
		. /etc/init.d/"$1"
		start
	)
}
# mount tmpfs on /dev
start_initd udev-mount || exit 1

# load device tarball
start_initd udev-dev-tarball

# run udevd
start_initd udev || exit 1

compat_volume_nodes

# udev started successfully
exit 0
