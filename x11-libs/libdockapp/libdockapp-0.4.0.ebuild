# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdockapp/libdockapp-0.4.0.ebuild,v 1.13 2004/07/15 00:46:58 agriffis Exp $

DESCRIPTION="Window Maker Dock Applet Library"
SRC_URI="http://www.minet.uni-jena.de/~topical/sveng/wmail/${P}.tar.gz"
HOMEPAGE="http://www.minet.uni-jena.de/~topical/sveng/wmail.html"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND="virtual/x11"

src_compile() {

	./configure --host=${CHOST} --prefix=/usr || die
	emake || die

}

src_install() {

	into /usr
	dolib src/libdockapp.la src/.libs/libdockapp.a
	insinto /usr/include
	doins src/dockapp.h
	dodoc README ChangeLog NEWS AUTHORS COPYING

}
