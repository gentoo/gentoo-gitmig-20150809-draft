# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-0.2.ebuild,v 1.2 2003/10/14 04:28:40 vapier Exp $

DESCRIPTION="userspace implementation of devfs"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-fs/sysfsutils"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Setup things to our liking
	sed -ie '/^#define UDEV_ROOT/ c\#define UDEV_ROOT    "/dev/"' udev.h
	sed -ie '/^#define NAMEDEV_CONFIG_ROOT/ c\#define NAMEDEV_CONFIG_ROOT "/etc/udev/"' \
		namedev.h
	# No need to clutter the logs ...
	sed -ie '/^DEBUG/ c\DEBUG = false' Makefile
	# Do not use optimization flags from the package
	sed -ie 's|$(OPTIMIZATION)||g' Makefile
	# Also use our own CFLAGS for libsysfs
	sed -ie "/^CFLAGS/ c\CFLAGS = ${CFLAGS}" libsysfs/Makefile

	# Make sure we do not build libsysfs
	# For now we use included libsysfs, as udev do not work with
	# latest libsysfs from sysfsutils yet ...
#	echo 'all:' > libsysfs/Makefile

	epatch ${FILESDIR}/${P}-major_minor-in-decimal.patch
}

src_compile() {
	# Do not work with emake
	make || die
}

src_install() {
	into /
	dosbin udev

	insinto /etc/udev
	doins namedev.config
#	doins ${FILESDIR}/namedev.permissions
	doins namedev.permissions

	dodoc COPYING ChangeLog README TODO
	dodoc docs/overview
}

