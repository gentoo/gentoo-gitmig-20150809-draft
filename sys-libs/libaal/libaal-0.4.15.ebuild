# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libaal/libaal-0.4.15.ebuild,v 1.2 2004/01/11 09:27:44 mr_bones_ Exp $

DESCRIPTION="libaal library required by reiser4progs"
HOMEPAGE="http://www.namesys.com/v4/v4.html"
SRC_URI="http://thebsh.namesys.com/snapshots/LATEST/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=""

src_compile() {
	./prepare || die "prepare failed"
	econf --libdir=/lib || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodir /usr/lib
	mv ${D}/lib/libaal.{a,la} ${D}/usr/lib/
	dodoc AUTHORS BUGS CREDITS ChangeLog NEWS README THANKS TODO
}
