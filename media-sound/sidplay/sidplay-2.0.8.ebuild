# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sidplay/sidplay-2.0.8.ebuild,v 1.4 2004/03/19 08:30:14 dholm Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C64 SID player"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sidplay2/${P}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/glibc
	>=media-libs/sidplay-libs-2.1.0"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc TODO AUTHORS ChangeLog
}
