# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icerrun/icerrun-0.5.ebuild,v 1.2 2003/07/31 17:12:53 lanius Exp $

DESCRIPTION="IceWM 'recently used programs' menu generator"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86"
RESTRICT="nostrip"

DEPEND=">=dev-lang/python-2.0"

SLOT="0"

src_compile () {
	einfo "No compilation necessary"
}

src_install () {
	exeinto /usr/bin
	doexe *.py
	dodoc README*
}
