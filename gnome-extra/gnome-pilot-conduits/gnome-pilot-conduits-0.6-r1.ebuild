# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pilot-conduits/gnome-pilot-conduits-0.6-r1.ebuild,v 1.2 2001/10/08 08:19:09 hallski Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Gnome Pilot Conduits"
SRC_URI="http://www.eskil.org/gnome-pilot/download/tarballs/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

DEPEND=">=gnome-extra/gnome-pilot-0.1.61-r1"

src_compile() {
	./configure --prefix=/usr 					\
		    --sysconfdir=/etc		 			\
		    --host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
