# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.2.ebuild,v 1.11 2004/02/17 23:05:35 agriffis Exp $

DESCRIPTION="spell library for GTK2"
HOMEPAGE="http://gtkspell.sourceforge.net/"
SRC_URI="http://gtkspell.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	virtual/aspell-dict"

src_compile() {
	econf `use_enable nls` || die
	emake || die "compile failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
