# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnome-pilot-conduits/gnome-pilot-conduits-0.6.ebuild,v 1.1 2001/10/05 08:29:55 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Gnome Pilot Conduits"
SRC_URI="http://www.eskil.org/gnome-pilot/download/tarballs/${A}"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

DEPEND=">=gnome-apps/gnome-pilot-0.1.61"

src_compile() {
	./configure --prefix=/opt/gnome 				\
		    --sysconfdir=/etc/opt/gnome 			\
		    --host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
