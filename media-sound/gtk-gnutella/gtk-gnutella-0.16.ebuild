# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Claes Nästen <pekdon@gmx.net>
# /home/cvsroot/gentoo-x86/skel.build,v 1.9 2001/10/21 16:17:12 agriffis Exp

S=${WORKDIR}/${P}

DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

DEPEND=">=x11-libs/gtk+-1.2.10"

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
}
