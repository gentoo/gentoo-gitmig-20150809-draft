# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-2.6.ebuild,v 1.3 2002/08/16 04:04:42 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A graphical file comparator and merge tool simular to xdiff."
SRC_URI="mirror://sourceforge/xxdiff/${P}.tar.gz"
HOMEPAGE="http://xxdiff.sourceforge.net/"

DEPEND="=x11-libs/qt-3*
	>=dev-util/tmake-1.8-r1"

RDEPEND="=x11-libs/qt-3*
	sys-apps/diffutils"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	cd src
	tmake -o Makefile xxdiff.pro

	emake || die
}

src_install () {
	dobin src/xxdiff
	doman src/xxdiff.1
	dodoc README COPYING CHANGES TODO
	dodoc copyright.txt
}
