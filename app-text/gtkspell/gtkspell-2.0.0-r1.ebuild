# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.0-r1.ebuild,v 1.5 2002/12/18 15:39:18 vapier Exp $

DESCRIPTION="GtkSpell is a spell library for GTK2"
SRC_URI="http://gtkspell.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gtkspell.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc"
SLOT="0"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=app-text/aspell-0.50"

src_compile() {
	econf `use_enable nls`
	emake || die "compile failure"
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
