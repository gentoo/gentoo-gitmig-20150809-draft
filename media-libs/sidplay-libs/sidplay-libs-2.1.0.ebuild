# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sidplay-libs/sidplay-libs-2.1.0.ebuild,v 1.1 2003/06/12 21:17:25 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C64 SID player library"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sidplay2/${P}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
