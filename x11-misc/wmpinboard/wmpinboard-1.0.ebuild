# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmpinboard/wmpinboard-1.0.ebuild,v 1.1 2002/05/26 21:54:38 bass Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="Window Maker dock applet resembling a miniature pinboard."
SRC_URI="http://www.tu-ilmenau.de/~gomar/stuff/wmpinboard/${P}.tar.bz2"
HOMEPAGE="http://www.tu-ilmenau.de/~gomar/stuff/wmpinboard"
LICENSE="GPL-2"
DEPEND="x11-base/xfree
		media-libs/xpm"

src_compile() {
    econf
    emake || die "emake failed"
}

src_install () {
    make DESTDIR=${D} install-strip || die "install failed"
}
	
