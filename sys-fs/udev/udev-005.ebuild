# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-005.ebuild,v 1.1 2003/10/23 20:23:09 azarah Exp $

DESCRIPTION="udev - Linux dynamic device naming support (aka userspace devfs)"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=sys-apps/hotplug-20030805-r1
	sys-fs/sysfsutils"

src_unpack() {
	unpack ${A}

	cd ${S}
	# No need to clutter the logs ...
	sed -ie '/^DEBUG/ c\DEBUG = false' Makefile
	# Do not use optimization flags from the package
	sed -ie 's|$(OPTIMIZATION)||g' Makefile

	# Make sure we do not build libsysfs
	# For now we use included libsysfs, as udev do not work with
	# latest libsysfs from sysfsutils yet ...
#	echo 'all:' > libsysfs/Makefile
}

src_compile() {
	# Do not work with emake
	make udevdir="/dev/" || die
}

src_install() {
	into /
	dosbin udev

	insinto /etc/udev
	doins udev.config
#	doins ${FILESDIR}/namedev.permissions
	doins udev.permissions

	dodir /etc/hotplug.d/default
	dosym ../../../sbin/udev /etc/hotplug.d/default/udev.hotplug

	doman udev.8

	dodoc COPYING ChangeLog FAQ README TODO
	dodoc docs/{overview,udev-OLS2003.pdf}
}

pkg_postinst() {
	# There changed names ...
	if [ -f "${ROOT}/etc/udev/namedev.config" -a \
	     ! -f "${ROOT}/etc/udev/udev.config" ]
	then
		mv -f ${ROOT}/etc/udev/namedev.config \
			${ROOT}/etc/udev/udev.config
	fi
	if [ -f "${ROOT}/etc/udev/namedev.permissions" -a \
	     ! -f "${ROOT}/etc/udev/udev.permissions" ]
	then
		mv -f ${ROOT}/etc/udev/namedev.permissions \
			${ROOT}/etc/udev/udev.permissions
	fi
}

