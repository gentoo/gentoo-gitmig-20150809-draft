# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+extra/gtk+extra-0.99.17.ebuild,v 1.13 2004/07/13 23:25:02 mr_bones_ Exp $

DESCRIPTION="Useful set of widgets for creating GUI's for the Xwindows system using GTK+."
HOMEPAGE="http://gtkextra.sourceforge.net/"
SRC_URI="http://gtkextra.sourceforge.net/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install () {
	make DESTDIR=${D} install || die "Installation Failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
