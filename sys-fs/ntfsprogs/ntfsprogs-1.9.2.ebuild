# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfsprogs/ntfsprogs-1.9.2.ebuild,v 1.1 2004/07/17 09:27:34 robbat2 Exp $

DESCRIPTION="User tools for NTFS filesystems -- includes: ntsresize, mkntfs,
ntfsfix, ntfsdefrag"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"
IUSE="gnome"
DEPEND=">sys-devel/gcc-2.95
	>=sys-apps/sed-4
	gnome? ( >=dev-libs/glib-2.0
		>=gnome-base/gnome-vfs-2.0 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

src_compile() {
	sed -i 's:head -1:head -n 1:g' getgccver
	econf `use_enable gnome gnome-vfs` || die "Configure failed"

	# I've added only this Makefile tweak, and we don't need
	# the gcc patch - Quequero
	sed -i -e "s:CFLAGS = -g -O2:CFLAGS = ${CFLAGS}:" \
	       -e "s:CPPFLAGS =:CPPFLAGS = ${CXXFLAGS}:" Makefile
	emake || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die "Install failed"
	dodoc AUTHORS COPYING CREDITS ChangeLog NEWS README TODO.* \
		doc/attribute_definitions doc/*.txt doc/tunable_settings

	# A normal user cannot run ntfsfix; move it over to the right place
	mv ${D}/usr/bin/ntfsfix ${D}/usr/sbin
	rmdir ${D}/usr/bin
}
