# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fxscintilla/fxscintilla-1.55.ebuild,v 1.1 2004/02/25 19:12:30 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scintilla is a free source code editing component for the FOX-Toolkit"
SRC_URI="http://savannah.nongnu.org/download/fxscintilla/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/fxscintilla"

SLOT="0"
KEYWORDS="~x86 ~sparc "
LICENSE="GPL-2"

DEPEND="fox"

src_compile() {
	econf || die
	emake || die "Parallel Make Failed"
}

src_install () {
	DESTDIR=${D} emake install || die
	dodoc README INSTALL 
}
