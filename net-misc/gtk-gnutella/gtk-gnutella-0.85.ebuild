# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Claes Nästen <pekdon@gmx.net>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtk-gnutella/gtk-gnutella-0.85.ebuild,v 1.2 2002/05/23 06:50:17 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO

	use gnome && ( \
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/gtk-gnutella.desktop
	)
}
