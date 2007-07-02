# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/iceiconcvt/iceiconcvt-1.0.ebuild,v 1.8 2007/07/02 14:57:55 peper Exp $

DESCRIPTION="IceWM icons' converter"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
RESTRICT="strip"
IUSE=""

DEPEND="dev-python/PyQt"

SLOT="0"

src_compile () {
	einfo "No compilation necessary"
}

src_install () {
	exeinto /usr/bin
	doexe iceiconcvt.py
	dodoc ChangeLog BUGS README.iceiconcvt TODO
}
