# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.90-r2.ebuild,v 1.2 2002/07/11 06:30:49 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"
SLOT="0"
LICENSE="GPL"

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
