# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfsprogs/ntfsprogs-1.7.1.ebuild,v 1.4 2004/02/01 13:20:39 plasmaroo Exp $

DESCRIPTION="User tools for NTFS filesystems -- includes: ntsresize, mkntfs,
ntfsfix, ntfsdefrag"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"

DEPEND=">sys-devel/gcc-2.95
	>=sys-apps/sed-4"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

src_compile() {
	epatch ${FILESDIR}/${P}-gcc3.patch || die
	sed -i 's:head -1:head -n 1:' configure
	econf || die "Configure failed"

	# I've added only this Makefile tweak, and we don't need
	# the gcc patch - Quequero
	sed -i -e "s:CFLAGS = -g -O2:CFLAGS = ${CFLAGS}:" \
	       -e "s:CPPFLAGS =:CPPFLAGS = ${CXXFLAGS}:" Makefile
	emake || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die "Install failed"

	# lot's of docs (a good thing :)
	dodoc AUTHORS COPYING CREDITS ChangeLog NEWS README TODO.* \
		doc/attribute_definitions doc/*.txt doc/tunable_settings

	# a normal user cannot run ntfsfix
	cd ${D}
	mv usr/bin/ntfsfix usr/sbin
	rmdir usr/bin
}
