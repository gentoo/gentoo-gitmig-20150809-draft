# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rpc/rpc-0.98.ebuild,v 1.7 2004/10/19 22:01:53 sekretarz Exp $

inherit eutils

DESCRIPTION="A fullscreen console-based RPN calculator that uses the curses library"

HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/rpc/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/rpc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""

DEPEND=">=dev-libs/ccmath-2.2
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gcc-34.patch
}

src_install() {
	einstall || die
	dodoc ChangeLog README TODO doc/{DESIGN,manual}
}
