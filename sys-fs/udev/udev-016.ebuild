# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-016.ebuild,v 1.1 2004/02/03 21:47:04 azarah Exp $

# Note: Cannot use external libsysfs with klibc ..
USE_KLIBC="no"
USE_EXT_LIBSYSFS="no"

inherit eutils

DESCRIPTION="Linux dynamic device naming support (aka userspace devfs)"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~hppa"

DEPEND="virtual/glibc
	>=sys-apps/hotplug-20030805-r1
	>=sys-fs/sysfsutils-0.3.0"

RDEPEND="${DEPEND}
	>=sys-apps/baselayout-1.8.6.12-r3"
# We need some changes for devfs type layout

pkg_setup() {
	[ "${USE_KLIBC}" = "yes" ] && check_KV

	return 0
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# No need to clutter the logs ...
	sed -ie '/^DEBUG/ c\DEBUG = false' Makefile
	# Do not use optimization flags from the package
	sed -ie 's|$(OPTIMIZATION)||g' Makefile

	# Make sure there is no sudden changes to udev.rules.devfs
	# (more for my own needs than anything else ...)
	if [ "`md5sum < "${S}/etc/udev/udev.rules.devfs"`" != \
	     "39311afa517b232c6a860371f009d2df  -" ]
	then
		echo
		eerror "udev.rules.devfs has been updated, please validate!"
		die "udev.rules.devfs has been updated, please validate!"
	fi

	# Make sure we do not build included libsysfs, but link to
	# one in sysfsutils ...
	if [ "${USE_EXT_LIBSYSFS}" = "yes" -a "${USE_KLIBC}" != "yes" ]
	then
		rm -rf ${S}/libsysfs
		cp -Rd ${ROOT}/usr/include/sysfs ${S}/libsysfs
	fi

	# Setup things for klibc
	if [ "${USE_KLIBC}" = "yes" ]
	then
		ln -snf ${ROOT}/usr/src/linux ${S}/klibc/linux
	fi

	# Do not sleep if UDEV_NO_SLEEP is set
	epatch ${FILESDIR}/${PN}-015-no-wait-for-sleep.patch

	# Make logging a udev.conf option
	epatch ${FILESDIR}/${P}-logging-config-option.patch
}

src_compile() {
	local myconf=

	# DBUS support?
	if which pkg-config &>/dev/null && pkg-config dbus-1 &>/dev/null
	then
		myconf="USE_DBUS=true"
	fi

	# Do not work with emake
	if [ "${USE_EXT_LIBSYSFS}" = "yes" -a "${USE_KLIBC}" != "yes" ]
	then
		make EXTRAS="extras/scsi_id" \
			udevdir="/dev/" \
			ARCH_LIB_OBJS="-lsysfs" \
			SYSFS="" \
			${myconf} || die
	else
		make EXTRAS="extras/scsi_id" \
			udevdir="/dev/" \
			${myconf} || die
	fi
}

src_install() {
	dobin udevinfo
	into /
	dosbin udev
	# *** Note that we do not yet use or install udevd and udevsend, ***
	# *** as they seem to be still too buggy (udevsend do not even   ***
	# *** start udevd over here ...                                  ***
#	dosbin udevd udevsend
	dosbin extras/scsi_id/scsi_id

	exeinto /etc/udev/scripts
	doexe extras/ide-devfs.sh

	insinto /etc/udev
	doins ${FILESDIR}/udev.conf
#	newins etc/udev/udev.rules udev.rules.example
	# For devfs style layout
	newins ${FILESDIR}/udev.rules.post_012 udev.rules
	# Our own custom udev.permissions
	doins ${FILESDIR}/udev.permissions
#	doins etc/udev/udev.permissions
	insinto /etc
	doins extras/scsi_id/scsi_id.config
	# DBUS support?
	if which pkg-config &>/dev/null && pkg-config dbus-1 &>/dev/null
	then
		insinto /etc/dbus-1/system.d
		doins etc/dbus-1/system.d/udev_sysbus_policy.conf
	fi

	dodir /etc/hotplug.d/default
	dosym ../../../sbin/udev /etc/hotplug.d/default/udev.hotplug

	doman *.8
	doman extras/scsi_id/scsi_id.8

	dodoc COPYING ChangeLog FAQ README TODO
	dodoc docs/{overview,udev-OLS2003.pdf,udev_vs_devfs}
}

pkg_preinst() {
	if [ -f "${ROOT}/etc/udev/udev.config" -a \
	     ! -f "${ROOT}/etc/udev/udev.rules" ]
	then
		mv -f ${ROOT}/etc/udev/udev.config ${ROOT}/etc/udev/udev.rules
	fi
}

