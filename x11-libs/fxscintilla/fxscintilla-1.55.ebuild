# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fxscintilla/fxscintilla-1.55.ebuild,v 1.5 2004/04/10 21:28:20 dholm Exp $

DESCRIPTION="A free source code editing component for the FOX-Toolkit"
HOMEPAGE="http://www.nongnu.org/fxscintilla"
SRC_URI="http://savannah.nongnu.org/download/fxscintilla/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="GPL-2"
IUSE=""

DEPEND="x11-libs/fox"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README INSTALL
}
