# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/resid/resid-0.13.ebuild,v 1.8 2004/07/14 20:25:31 agriffis Exp $

DESCRIPTION="C++ library to emulate the C64 SID chip"
HOMEPAGE="http://sidplay2.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/sidplay2/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "
IUSE=""
DEPEND=""

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
