# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/matroxset/matroxset-0.4.ebuild,v 1.3 2006/07/02 23:20:14 pylon Exp $

IUSE=""

DESCRIPTION="Matrox utility to switch output modes (activate tvout)"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/${P}.tar.gz"

DEPEND="virtual/libc
	sys-libs/ncurses"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"

src_compile() {
	cd ${S}
#	make clean || die
	make all || die

	#prepare small README
	cat >> ${S}/README << _EOF_
This utility has been created by Petr Vandrovec

Not much info here, but here are some pointers
http://davedina.apestaart.org/download/doc/Matrox-TVOUT-HOWTO-0.1.txt
http://www.netnode.de/howto/matrox-fb.html
_EOF_
}

src_install() {
	dobin matroxset

	dodoc README
}
