# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.4.ebuild,v 1.2 2003/03/08 04:13:26 azarah Exp $

DESCRIPTION="spell library for GTK2"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gtkspell.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"
SLOT="0"
IUSE="doc"

DEPEND=">=x11-libs/gtk+-2
	>=app-text/aspell-0.50
	doc? ( dev-util/gtk-doc )"

src_compile() {
	myconf=

	use doc || myconf="--disable-gtk-doc"
	
	econf ${myconf} || die
	emake || die "compile failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
