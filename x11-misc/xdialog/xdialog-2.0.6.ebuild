# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdialog/xdialog-2.0.6.ebuild,v 1.4 2003/12/17 16:26:31 vapier Exp $

S=${WORKDIR}/${P/x/X}
DESCRIPTION="drop-in replacement for cdialog using GTK"
HOMEPAGE="http://xdialog.dyns.net/"
SRC_URI="http://ftp.debian.org/debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
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
