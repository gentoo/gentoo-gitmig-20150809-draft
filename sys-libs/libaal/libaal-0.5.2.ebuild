# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libaal/libaal-0.5.2.ebuild,v 1.1 2004/06/17 22:42:02 vapier Exp $

DESCRIPTION="libaal library required by reiser4progs"
HOMEPAGE="http://www.namesys.com/v4/v4.html"
SRC_URI="http://thebsh.namesys.com/snapshots/2004.06.14-internal.testing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=""

src_compile() {
	econf --libdir=/lib || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodir /usr/lib
	mv ${D}/lib/libaal.{a,la} ${D}/usr/lib/
	dodoc AUTHORS BUGS CREDITS ChangeLog NEWS README THANKS TODO
}
