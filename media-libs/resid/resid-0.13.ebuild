# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/resid/resid-0.13.ebuild,v 1.2 2002/08/14 13:08:10 murphy Exp $

DESCRIPTION="C++ library to emulate the C64 SID chip"
HOMEPAGE="http://sidplay2.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/sidplay2/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"
DEPEND=""
RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

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
