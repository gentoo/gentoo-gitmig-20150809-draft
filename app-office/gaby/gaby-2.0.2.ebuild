# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/app-office/gaby/gaby-2.0.2.ebuild,v 1.1 2001/08/06 06:15:08 csjoly Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small personal databases manager for Linux"
SRC_URI="http://gaby.sourceforge.net/archives/${P}.tar.gz"
HOMEPAGE="http://gaby.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.8
		virtual/python
		>=gnome-base/gdk-pixbuf-0.7.0
		gnome-base/libxml
		dev-python/gnome-python
		gnome-base/libglade
		gnome? ( >=gnome-base/gnome-libs-1.2.8 )
		esd? ( >=media-sound/esound-0.2.8 )
		nls? ( sys-devel/gettext )"

# Image fields require ( >= (media-libs/imlib-1.9.3 ||
#							gnome-base/gdk-pixbuf-0.7.0 ))
# Sound fields require ( >=media-sound/esound-0.2.8 )
# form layout requires ( gnome-base/libglade )

src_compile() {

	local myopts

	if [ "`use gnome`" ]
	then
		prefix="/opt/gnome"
		myopts="--enable-gnome"
	else
		prefix="/usr/X11R6"
		myopts="--disable-gnome"
	fi

	if [ -z "`use nls`" ]
	then
		myopts="$myopts --disable-nls"
	fi

	cp ${FILESDIR}/Makefile.in intl/Makefile.in

	cp configure configure.orig
	sed -e "7293 c\ if test -f /usr/include/pygtk/pygtk.h; then" \
	< configure.orig > configure

	try ./configure  --host=${CHOST} ${myopts} --prefix=${prefix}

	cd src
	cp Makefile Makefile.orig
	sed -e "s:install-exec-local::" \
	    -e "s:^\::gentoo change\::" Makefile.orig > Makefile
	cd ..

    try emake

}

src_install () {

	try make DESTDIR=${D} install

	dosym gaby ${prefix}/bin/gbc
	dosym gaby ${prefix}/bin/gcd
	dosym gaby ${prefix}/bin/videobase
	dosym gaby ${prefix}/bin/gnomecard
	dosym gaby ${prefix}/bin/appindex

	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS
	dodoc README TODO TODO.more

	insinto ${prefix}/share/pixmaps
	insopt -m 0644
	doins gnome-gaby-builder.png gnome-gaby.png
	
}

