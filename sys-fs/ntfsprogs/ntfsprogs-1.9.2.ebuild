# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfsprogs/ntfsprogs-1.9.2.ebuild,v 1.2 2004/07/28 21:43:27 vapier Exp $

DESCRIPTION="User tools for NTFS filesystems"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="gnome"

DEPEND=">sys-devel/gcc-2.95
	>=sys-apps/sed-4
	gnome? ( >=dev-libs/glib-2.0
		>=gnome-base/gnome-vfs-2.0 )"

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
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO.* \
		doc/attribute_definitions doc/*.txt doc/tunable_settings

	# A normal user cannot run ntfsfix; move it over to the right place
	mv ${D}/usr/bin/ntfsfix ${D}/usr/sbin
	rmdir ${D}/usr/bin
}
