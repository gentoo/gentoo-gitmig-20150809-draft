# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsidplay/libsidplay-2.1.0.20021111.ebuild,v 1.3 2003/06/12 16:18:37 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="C64 SID player library"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="http://www-ti.informatik.uni-tuebingen.de/~bwurst/${P}.tar.bz2"
IUSE=""
SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL
}
