# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl-mccp/tcl-mccp-0.6.ebuild,v 1.1 2004/08/28 19:02:02 cardoe Exp $

IUSE=""
DESCRIPTION="mccp extension to TCL"
HOMEPAGE="http://tcl-mccp.sf.net/"
SRC_URI="mirror://sourceforge/tcl-mccp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="dev-lang/tcl"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	einstall || die
}
