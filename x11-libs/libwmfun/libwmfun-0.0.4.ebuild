# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libwmfun/libwmfun-0.0.4.ebuild,v 1.2 2002/08/14 13:05:59 murphy Exp $

DESCRIPTION="Additional FUN! WindowMaker library"
HOMEPAGE="http://www.windowmaker.org"
SRC_URI="http://www.windowmaker.org/pub/libs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc
	x11-wm/WindowMaker
	>=media-libs/freetype-2.0.9"

S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/proplist-freetype2.diff

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
