# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libwmfun/libwmfun-0.0.4.ebuild,v 1.7 2004/04/17 23:02:17 aliz Exp $

inherit eutils

DESCRIPTION="Additional FUN! WindowMaker library"
HOMEPAGE="http://www.windowmaker.org"
SRC_URI="http://www.windowmaker.org/pub/libs/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc
	x11-wm/windowmaker
	>=media-libs/freetype-2.0.9"

src_unpack() {

	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/proplist-freetype2.diff

}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

}
