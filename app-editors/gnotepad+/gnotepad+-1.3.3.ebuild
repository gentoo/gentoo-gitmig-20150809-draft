# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gnotepad+/gnotepad+-1.3.3.ebuild,v 1.2 2004/03/13 23:00:56 mr_bones_ Exp $

DESCRIPTION="Gnotepad+ is a simple HTML and text editor using the GTK Text Widget."
SRC_URI="http://download.sourceforge.net/gnotepad/${P}.tar.gz"
HOMEPAGE="http://gnotepad.sourceforge.net/"
DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
}
