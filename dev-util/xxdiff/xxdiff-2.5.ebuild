# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-2.5.ebuild,v 1.2 2002/05/27 17:27:38 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A graphical file comparator and merge tool simular to xdiff."
SRC_URI="mirror://sourceforge/xxdiff/${P}.tar.gz"
HOMEPAGE="http://xxdiff.sourceforge.net/"

DEPEND="virtual/glibc
	=x11-libs/qt-2.3*
	>=dev-util/tmake-1.8-r1
	>=sys-devel/gcc-2.95.3"

RDEPEND="sys-apps/diffutils"

src_compile() {
	export QTDIR=/usr/qt/2
	cd src
	tmake -o Makefile xxdiff.pro

	emake || die
}

src_install () {
	dobin src/xxdiff
	newman src/xxdiff.man xxdiff.1
	dodoc README COPYING CHANGES TODO
	dodoc copyright.txt doc/xxdiff-doc.sgml
}

# vim: ai et sw=4 ts=4
