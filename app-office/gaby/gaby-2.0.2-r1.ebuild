# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/gaby/gaby-2.0.2-r1.ebuild,v 1.5 2002/07/25 19:29:33 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small personal databases manager for Linux"
SRC_URI="http://gaby.sourceforge.net/archives/${P}.tar.gz"
HOMEPAGE="http://gaby.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	virtual/python
	>=media-libs/gdk-pixbuf-0.11.0-r1
	dev-libs/libxml
	dev-python/gnome-python
	>=gnome-base/libglade-0.17-r1
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	esd? ( >=media-sound/esound-0.2.8 )
	nls? ( sys-devel/gettext )"

# Image fields require ( >= (media-libs/imlib-1.9.10-r1 ||
#			media-libs/gdk-pixbuf-0.11.0-r1 ))
# Sound fields require ( >=media-sound/esound-0.2.8 )
# form layout requires ( >=gnome-base/libglade-0.17-r1 )

src_compile() {

	local myopts

	if [ "`use gnome`" ]
	then
		myopts="--enable-gnome"
	else
		myopts="--disable-gnome"
	fi

	if [ -z "`use nls`" ]
	then
		myopts="${myopts} --disable-nls"
	fi

	cp ${FILESDIR}/Makefile.in intl/Makefile.in

	cp configure configure.orig
	sed -e "7293 c\ if test -f /usr/include/pygtk/pygtk.h; then" \
	< configure.orig > configure

	./configure 	\
		--host=${CHOST}	\
		${myopts}	\
		--prefix=/usr || die

	cd src
	cp Makefile Makefile.orig
	sed -e "s:install-exec-local::" \
		-e "s:^\::gentoo change\::" Makefile.orig > Makefile
	cd ..

	emake || die

}

src_install () {

	make DESTDIR=${D} install || die

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
