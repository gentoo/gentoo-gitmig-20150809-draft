# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xwpe/xwpe-1.5.29a.ebuild,v 1.1 2002/07/14 20:42:14 stroke Exp $

DESCRIPTION="An IDE to Develop in text and graphical mode"
HOMEPAGE="http://www.identicalsoftware.com/xwpe/"

LICENSE="GPL-2"

DEPEND=">=sys-libs/gpm-1.20.0 \
	>=sys-libs/ncurses-5.2 \
	>=sys-libs/zlib-1.1.4"

RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="*"

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
