# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.2.ebuild,v 1.7 2003/03/01 04:17:59 vapier Exp $

DESCRIPTION="spell library for GTK2"
SRC_URI="http://gtkspell.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gtkspell.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"
SLOT="0"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=app-text/aspell-0.50"

src_compile() {
	econf `use_enable nls` || die
	emake || die "compile failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
