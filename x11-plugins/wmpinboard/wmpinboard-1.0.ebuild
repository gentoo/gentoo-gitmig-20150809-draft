# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpinboard/wmpinboard-1.0.ebuild,v 1.10 2004/04/26 15:01:17 agriffis Exp $

IUSE=""
DESCRIPTION="Window Maker dock applet resembling a miniature pinboard."
SRC_URI="http://www.tu-ilmenau.de/~gomar/stuff/wmpinboard/${P}.tar.bz2"
HOMEPAGE="http://www.tu-ilmenau.de/~gomar/stuff/wmpinboard"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha amd64 ~ppc"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install-strip || die "install failed"
}

