# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xwpe/xwpe-1.5.29a.ebuild,v 1.8 2003/09/05 23:05:05 msterret Exp $

DESCRIPTION="An IDE to Develop in text and graphical mode"
HOMEPAGE="http://www.identicalsoftware.com/xwpe/"

LICENSE="GPL-2"

DEPEND=">=sys-libs/gpm-1.20.0 \
	>=sys-libs/ncurses-5.2 \
	>=sys-libs/zlib-1.1.4"

SLOT="0"
KEYWORDS="x86 ppc sparc "

SRC_URI="http://www.identicalsoftware.com/xwpe/${P}.tar.gz"

S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=${D}/usr/share/info \
		--mandir=${D}/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die
	dodoc 	INSTALL README CHANGELOG
}
