# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess/gnuchess-5.04.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console based chess interface"
SRC_URI="ftp://ftp.gnu.org/gnu/chess/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr
	emake || die
}
src_install () {
	make \
		prefix=${D}/usr \
		install || die
}
