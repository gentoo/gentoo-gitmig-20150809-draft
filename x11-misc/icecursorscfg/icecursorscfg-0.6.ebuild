# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icecursorscfg/icecursorscfg-0.6.ebuild,v 1.6 2004/03/24 11:21:21 phosphan Exp $

DESCRIPTION="IceWM cursor's configurator"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86"
RESTRICT="nostrip"
IUSE=""

DEPEND="dev-python/PyQt"

SLOT="0"

src_compile () {
	einfo "No compilation necessary"
}

src_install () {
	exeinto /usr/bin
	doexe icecurcfg.py
	dodoc ChangeLog
}
