# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-024-r1.ebuild,v 1.1 2004/04/02 23:48:15 gregkh Exp $

# Note: Cannot use external libsysfs with klibc ..
USE_KLIBC="no"

inherit eutils

DESCRIPTION="Linux dynamic and persistent device naming support (aka userspace devfs)"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~mips"

DEPEND="virtual/glibc
	sys-apps/hotplug-base"

RDEPEND="${DEPEND}
	>=sys-apps/baselayout-1.8.6.12-r3"
# We need some changes for devfs type layout

PROVIDE="virtual/dev-manager"

pkg_setup() {
	[ "${USE_KLIBC}" = "yes" ] && check_KV

	return 0
}

src_unpack() {
	unpack ${A}

	cd ${S}

	# patches go here...
	# epatch ${FILESDIR}/${P}-udev_add_c-gcc295-compat.patch

	# No need to clutter the logs ...
	sed -ie '/^DEBUG/ c\DEBUG = false' Makefile
	# Do not use optimization flags from the package
	sed -ie 's|$(OPTIMIZATION)||g' Makefile

	# Make sure there is no sudden changes to udev.rules.gentoo
	# (more for my own needs than anything else ...)
	if [ "`md5sum < "${S}/etc/udev/udev.rules.gentoo"`" != \
	     "9c319a3ec523f5407e0fc12a9da4f713  -" ]
	then
		echo
		eerror "udev.rules.gentoo has been updated, please validate!"
		die "udev.rules.gentoo has been updated, please validate!"
	fi

	# Setup things for klibc
	if [ "${USE_KLIBC}" = "yes" ]
	then
		ln -snf ${ROOT}/usr/src/linux ${S}/klibc/linux
	fi
}

src_compile() {
	local myconf=
	local extras="extras/scsi_id"

	# DBUS support?
	# disabled for now as it's currently broken.
#	if which pkg-config &>/dev/null && pkg-config dbus-1 &>/dev/null
#	then
#		myconf="USE_DBUS=true"
#	fi

	# Device-mapper support?
	if false
	then
		extras="${extras} extras/multipath"
	fi

	# Do not work with emake
	make EXTRAS="${extras}" \
		udevdir="/dev/" \
		${myconf} || die
}

src_install() {
	dobin udevinfo udevtest
	into /
	dosbin udev udevd udevsend udevstart
	dosbin extras/scsi_id/scsi_id
	# Device-mapper support?
	if false
	then
		dosbin extras/multipath/{multipath,devmap_name}
		exeinto /etc/hotplug.d/scsi/
		doexe extras/multipath/multipath.hotplug
	fi

	exeinto /etc/udev/scripts
	doexe extras/ide-devfs.sh
	doexe extras/scsi-devfs.sh

	insinto /etc/udev
	doins ${FILESDIR}/udev.conf
#	newins etc/udev/udev.rules udev.rules.example
	# For devfs style layout
	newins etc/udev/udev.rules.gentoo udev.rules
	# Our own custom udev.permissions
	newins etc/udev/udev.permissions.gentoo udev.permissions
#	doins ${FILESDIR}/udev.permissions
#	doins etc/udev/udev.permissions
	insinto /etc
	doins extras/scsi_id/scsi_id.config

	# DBUS support?
#	if which pkg-config &>/dev/null && pkg-config dbus-1 &>/dev/null
#	then
#		insinto /etc/dbus-1/system.d
#		doins etc/dbus-1/system.d/udev_sysbus_policy.conf
#	fi

	dodir /etc/hotplug.d/default
	dosym ../../../sbin/udevsend /etc/hotplug.d/default/udev.hotplug

	# set up the /etc/dev.d directory tree
	dodir /etc/dev.d/default
	dodir /etc/dev.d/net
	exeinto /etc/dev.d/net
	doexe etc/dev.d/net/hotplug.dev

	doman *.8
	doman extras/scsi_id/scsi_id.8

	dodoc COPYING ChangeLog FAQ HOWTO-udev_for_dev README TODO
	dodoc docs/{overview,udev-OLS2003.pdf,udev_vs_devfs,RFC-dev.d}
}

pkg_preinst() {
	if [ -f "${ROOT}/etc/udev/udev.config" -a \
	     ! -f "${ROOT}/etc/udev/udev.rules" ]
	then
		mv -f ${ROOT}/etc/udev/udev.config ${ROOT}/etc/udev/udev.rules
	fi
}

pkg_postinst() {
	if [ "${ROOT}" = "/" -a -n "`pidof udevd`" ]
	then
		killall -15 udevd &>/dev/null
		sleep 1
		killall -9 udevd &>/dev/null
	fi
}
