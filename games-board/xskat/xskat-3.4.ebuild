# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xskat/xskat-3.4.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

DESCRIPTION="XSkat - famous german card game for X11"
HOMEPAGE="http://www.gulu.net/xskat"
SRC_URI="http://www.gulu.net/xskat/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11"

src_compile() {
	./configure \
	--host=${CHOST} \
	--prefix=/usr \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man || die "./configure failed"
emake || die
}

src_install() {
	make DESTDIR=${D} install install.man || die
}
