# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnome-pilot/gnome-pilot-0.1.61.ebuild,v 1.2 2001/10/05 08:30:49 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Gnome Pilot apps"
SRC_URI="http://www.eskil.org/gnome-pilot/download/tarballs/${A}"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

DEPEND=">=gnome-base/gnome-core-1.4.0.4
	>=gnome-base/gnome-env-1.0
	>=gnome-base/control-center-1.4.0.1
	>=dev-libs/pilot-link-0.9.5"

src_compile() {
	./configure --prefix=/opt/gnome 				\
		    --with-gnome-libs=/opt/gnome/lib			\
		    --sysconfdir=/etc/opt/gnome 			\
		    --enable-usb-visor=yes 				\
		    --host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
