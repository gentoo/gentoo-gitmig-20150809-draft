# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rpc/rpc-0.97-r1.ebuild,v 1.3 2003/09/05 12:14:10 msterret Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="a fullscreen console-based RPN calculator that uses the curses library."

SRC_URI="http://www.eecs.umich.edu/~pelzlpj/rpc/${P}.tar.gz"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/rpc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"

DEPEND=">=dev-libs/ccmath-2.2
	sys-libs/ncurses"

src_compile() {

	epatch ${FILESDIR}/${P}-factorial-fix.diff.bz2
	econf || die "econf failed"
	make || die "make failed"

}

src_install() {

	einstall || die
	dodoc AUTHORS COPYING INSTALL NEWS README doc/DESIGN doc/manual

}
