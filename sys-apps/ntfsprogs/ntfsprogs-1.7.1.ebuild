# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ntfsprogs/ntfsprogs-1.7.1.ebuild,v 1.1 2003/06/01 04:41:15 lostlogic Exp $

DESCRIPTION="Utilities and library for accessing NTFS filesystems"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"

DEPEND=">=sys-devel/gcc-2.95"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	econf || die "Configure failed"

	# I've added only this Makefile tweak, and we don't need
	# the gcc patch - Quequero
	cp Makefile Makefile.orig
	sed -i -e "s:CFLAGS = -g -O2:CFLAGS = ${CFLAGS}:" \
	       -e "s:CPPFLAGS =:CPPFLAGS = ${CXXFLAGS}:" Makefile
	emake || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die "Install failed"

	# lot's of docs (a good thing :)
	dodoc CREDITS ChangeLog NEWS README TODO.include TODO.mkntfs TODO.ntfsfix \
		doc/attribute_definitions doc/attributes.txt doc/compression.txt \
		doc/system_files.txt doc/system_security_descriptors.txt \
		doc/tunable_settings

	# a normal user cannot run ntfsfix
	cd ${D}
	mv usr/bin/ntfsfix usr/sbin
	rmdir usr/bin
}
