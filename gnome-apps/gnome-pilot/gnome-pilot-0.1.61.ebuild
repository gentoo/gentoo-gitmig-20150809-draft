# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnome-pilot/gnome-pilot-0.1.61.ebuild,v 1.1 2001/10/04 23:08:53 hallski Exp $


A1=${P}.tar.gz
A2=${PN}-conduits-0.6.tar.gz
S1=${WORKDIR}/${P}
S2=${WORKDIR}/${PN}-conduits-0.6

DESCRIPTION="Gnome Pilot apps"
SRC_URI="http://www.eskil.org/gnome-pilot/download/tarballs/${A1}
 	 http://www.eskil.org/gnome-pilot/download/tarballs/${A2}"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

DEPEND=">=gnome-base/gnome-core-1.4.0.4
	>=gnome-base/gnome-env-1.0
	>=gnome-base/control-center-1.4.0.1
	>=dev-libs/pilot-link-0.9.5"

src_unpack() {
	unpack ${A1}
	unpack ${A2}
}

src_compile() {
	cd ${S1}
	./configure --prefix=/opt/gnome 				\
		    --with-gnome-libs=/opt/gnome/lib			\
		    --sysconfdir=/etc/opt/gnome 			\
		    --enable-usb-visor=yes 				\
		    --host=${CHOST} || die

	emake || die

	cd ${S2}
	./configure --prefix=/opt/gnome 				\
		    --sysconfdir=/etc/opt/gnome 			\
		    --host=${CHOST} || die

	emake || die
}

src_install () {
	cd ${S1}
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS

	cd ${S2}
	make DESTDIR=${D} install || die
}
