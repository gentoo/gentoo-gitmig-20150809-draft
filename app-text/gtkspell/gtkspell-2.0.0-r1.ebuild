# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.0-r1.ebuild,v 1.9 2003/08/05 15:56:04 vapier Exp $

DESCRIPTION="spell library for GTK2"
HOMEPAGE="http://gtkspell.sourceforge.net/"
SRC_URI="http://gtkspell.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	virtual/aspell-dict"

src_compile() {
	econf `use_enable nls` || die
	emake || die "compile failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
