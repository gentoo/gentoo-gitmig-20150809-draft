# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-2.6.ebuild,v 1.1 2002/07/02 05:05:40 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A graphical file comparator and merge tool simular to xdiff."
SRC_URI="mirror://sourceforge/xxdiff/${P}.tar.gz"
HOMEPAGE="http://xxdiff.sourceforge.net/"

DEPEND="=x11-libs/qt-3*
	>=dev-util/tmake-1.8-r1"

RDEPEND="sys-apps/diffutils"

SLOT=""
LICENSE="GPL"

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
