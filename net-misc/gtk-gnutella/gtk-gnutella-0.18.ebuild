# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Claes N�sten <pekdon@gmx.net>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtk-gnutella/gtk-gnutella-0.18.ebuild,v 1.1 2001/12/13 20:28:33 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-1.2.10"

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
	if use gnome; then
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/gtk-gnutella.desktop
		#insinto /usr/share/pixmaps
		#doins ${FILESDIR}/gtk-gnutella.png
	fi
}
