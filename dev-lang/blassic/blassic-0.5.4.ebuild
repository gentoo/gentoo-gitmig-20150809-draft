# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/blassic/blassic-0.5.4.ebuild,v 1.1 2003/07/31 21:45:01 rphillips Exp $

S=${WORKDIR}/${P}
SRC_URI="http://www.arrakis.es/~ninsesabe/blassic/${P}.tgz"
HOMEPAGE="http://www.arrakis.es/~ninsesabe/blassic/index.html"
DESCRIPTION="Blassic is a classic Basic interpreter"
LICENSE="GPL"
KEYWORDS="x86 ppc hppa "
SLOT="0"
DEPEND="sys-libs/ncurses"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
