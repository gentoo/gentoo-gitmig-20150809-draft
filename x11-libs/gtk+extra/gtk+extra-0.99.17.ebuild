# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+extra/gtk+extra-0.99.17.ebuild,v 1.16 2005/01/05 00:20:36 kingtaco Exp $
inherit gnuconfig

DESCRIPTION="Useful set of widgets for creating GUI's for the Xwindows system using GTK+."
HOMEPAGE="http://gtkextra.sourceforge.net/"
SRC_URI="http://gtkextra.sourceforge.net/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc ~amd64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"

src_compile() {
	gnuconfig_update
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install () {
	make DESTDIR=${D} install || die "Installation Failed"
	dodoc AUTHORS ChangeLog INSTALL README
}
