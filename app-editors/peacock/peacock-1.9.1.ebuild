# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/peacock/peacock-1.9.1.ebuild,v 1.4 2004/08/28 14:01:06 usata Exp $

IUSE=""

DESCRIPTION="A simple GTK HTML editor"
SRC_URI="mirror://sourceforge/peacock/${P}.tar.gz"
HOMEPAGE="http://peacock.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2
	dev-util/pkgconfig
	x11-libs/gtksourceview"

src_compile() {

	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}
