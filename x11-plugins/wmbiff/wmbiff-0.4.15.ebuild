# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbiff/wmbiff-0.4.15.ebuild,v 1.4 2003/09/29 21:53:11 mholzer Exp $

DESCRIPTION="WMBiff is a dock applet for WindowMaker which can monitor up to 5 mailboxes."
SRC_URI="mirror://sourceforge/wmbiff/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbiff/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"


src_compile() {
	cd ${S}
	econf
	emake || die
}

src_install () {
	einstall
	dodoc ChangeLog  FAQ NEWS  README  README.licq  TODO
}
