# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+extra/gtk+extra-0.99.17.ebuild,v 1.8 2002/12/09 04:41:46 manson Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Useful set of widgets for creating GUI's for the Xwindows system using GTK+."

SRC_URI="http://gtkextra.sourceforge.net/src/${P}.tar.gz"

HOMEPAGE="http://gtkextra.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="=x11-libs/gtk+-1.2*"

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

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}
