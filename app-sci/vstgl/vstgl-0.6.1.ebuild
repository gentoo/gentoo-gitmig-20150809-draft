# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/vstgl/vstgl-0.6.1.ebuild,v 1.4 2004/04/19 12:47:51 phosphan Exp $

inherit eutils

IUSE=""

DESCRIPTION="Visual Signal Transition Graph Lab"
HOMEPAGE="http://vstgl.sourceforge.net/"
SRC_URI="http://vstgl.sourceforge.net/vstgl-0.6.1.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="x11-libs/qt
	media-libs/libpng
	sys-libs/zlib"
	# dev-util/kdoc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-qt3-gcc32.patch
	rm -rf CVS */CVS */*/CVS */*/*/CVS;
}

src_compile() {
	emake
}

src_install () {
	newbin vstgl-linux-0.6.1 vstgl
	dodoc README AUTHORS COPYING
	dodir /usr/share/doc/${P}/
	cp -a examples ${D}/usr/share/doc/${P}/
	cp -a Help ${D}/usr/share/doc/${P}
}




