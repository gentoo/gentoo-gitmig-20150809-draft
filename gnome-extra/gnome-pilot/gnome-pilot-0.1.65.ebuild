# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pilot/gnome-pilot-0.1.65.ebuild,v 1.1 2002/04/24 22:52:42 spider Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Gnome Pilot apps"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/unstable/sources/gnome-pilot/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

DEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	>=gnome-base/control-center-1.4.0.1-r1
	>=dev-libs/pilot-link-0.9.6
	>=dev-util/gob-1.0.12
	>=gnome-base/libglade-0.17
	nls? ( sys-devel/gettext )"

src_compile() {
	local myopts

	CFLAGS="${CFLAGS} `gnome-config --cflags libglade vfs`"

	if [ "`use nls`" ]
	then
		myopts="--enable-nls"
	else
		myopts="--disable-nls"
	fi

	mkdir intl && touch intl/libgettext.h
	
	./configure --prefix=/usr	 				\
		    --with-gnome-libs=/usr/lib				\
		    --mandir=/usr/share/man	 			\
		    --sysconfdir=/etc		 			\
		    --enable-usb-visor=yes 				\
		    ${myopts}		 				\
		    --host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
