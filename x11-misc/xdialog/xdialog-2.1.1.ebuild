# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdialog/xdialog-2.1.1.ebuild,v 1.5 2004/09/07 16:25:59 blubb Exp $

S=${WORKDIR}/${P/x/X}
DESCRIPTION="drop-in replacement for cdialog using GTK"
HOMEPAGE="http://xdialog.dyns.net/"
SRC_URI="http://freshmeat.net/redir/xdialog/11876/url_bz2/Xdialog-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
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
