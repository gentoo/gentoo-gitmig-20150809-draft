# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rpc/rpc-0.97.ebuild,v 1.4 2003/09/05 12:10:36 msterret Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="rpc is a fullscreen console-based RPN calculator that uses the curses library. Its operation is similar to that
	of modern HP calculators, but data entry has been optimized for efficiency on a PC keyboard. Its features include
	extensive scientific calculator functionality, command completion, and a visible interactive stack."

SRC_URI="http://www.eecs.umich.edu/~pelzlpj/rpc/${P}.tar.gz"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/rpc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"

DEPEND=">=dev-libs/ccmath-2.2
	sys-libs/ncurses"

src_compile() {

	econf || die "econf failed"
	make || die "make failed"

}

src_install() {

	einstall || die
	dodoc AUTHORS COPYING INSTALL NEWS README doc/DESIGN doc/manual

}
