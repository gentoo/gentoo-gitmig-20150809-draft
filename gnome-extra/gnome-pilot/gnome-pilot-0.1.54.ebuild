# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pilot/gnome-pilot-0.1.54.ebuild,v 1.2 2001/07/12 19:43:49 lamer Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/gnome-pilot-0.1.54
DESCRIPTION="Gnome Pilot apps"
SRC_URI="http://canvas.gnome.org:65348/gnome-pilot/download/${A}"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

DEPEND=">=gnome-base/gnome-core-1.4.0.4
		  >=gnome-base/gnome-env-1.0
		  >=gnome-base/control-center-1.4.0.1
		 >=dev-libs/pilot-link-0.9.5"

src_compile() {

    try ./configure --prefix=/opt/gnome --with-gnome-libs=/opt/gnome/lib\
	--sysconfdir=/etc/opt/gnome --enable-usb-visor=yes --host=${CHOST}
    try make

}

src_install () {

	try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
	dodoc AUTHORS COPYING* ChangeLog README NEWS

}


