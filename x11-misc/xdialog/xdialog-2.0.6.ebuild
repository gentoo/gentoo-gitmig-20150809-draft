# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdialog/xdialog-2.0.6.ebuild,v 1.6 2004/06/24 22:39:46 agriffis Exp $

S=${WORKDIR}/${P/x/X}
DESCRIPTION="drop-in replacement for cdialog using GTK"
HOMEPAGE="http://xdialog.dyns.net/"
SRC_URI="mirror://debian/pool/main/x/xdialog/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc ChangeLog AUTHORS COPYING INSTALL README* TODO ABOUT-NLS

	cd doc
	dohtml -r .
}
