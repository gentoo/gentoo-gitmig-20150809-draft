# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpinboard/wmpinboard-1.0.ebuild,v 1.5 2003/06/17 21:40:43 wwoods Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="Window Maker dock applet resembling a miniature pinboard."
SRC_URI="http://www.tu-ilmenau.de/~gomar/stuff/wmpinboard/${P}.tar.bz2"
HOMEPAGE="http://www.tu-ilmenau.de/~gomar/stuff/wmpinboard"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha"

src_compile() {
	econf
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install-strip || die "install failed"
}
	
