# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.0-r1.ebuild,v 1.1 2002/08/23 17:52:07 seemant Exp $

DESCRIPTION="GtkSpell is a spell library for GTK2"

SRC_URI="http://gtkspell.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gtkspell.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=app-text/aspell-0.50"

DEPEND="$RDEPEND"

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"

	econf \
		--enable-debug=yes \
		${myconf} || die "configure failure"

	emake || die "compile failure"
}

src_install() {
	einstall || die "installation failed"
    
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
