# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gliv/gliv-1.5.1.ebuild,v 1.5 2002/07/11 06:30:27 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An image viewer that uses OpenGL"
SRC_URI="http://gliv.tuxfamily.org/gliv-${PV}.tar.bz2"
HOMEPAGE="http://gliv.tuxfamily.org"

# as from version 1.5.1, it could use gtk+-2.0, but not
# gtkglarea-1.99.0 yet, thus we have to use gtk-1.2 ...
# please check this with future versions !!!!
DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	<x11-libs/gtkglarea-1.99.0
	virtual/opengl"


src_compile() {

	local myconf=""

	# Dont use gtk+-2.0 until we can use >=gtkglarea-1.99.0
	myconf="${myconf} --disable-gtk2"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		${myconf} || die
	
	emake || die
}

src_install() {

    make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die
    
    dodoc COPYING README NEWS THANKS
}
