# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.0.6-r1.ebuild,v 1.5 2002/07/22 14:37:06 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"
HOMEPAGE="http://enlightenment.org/"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.2.1
	>=media-libs/tiff-3.5.5
	<=media-libs/freetype-1.4
	dev-db/edb"

src_compile() {
	# always turn off mmx because binutils 2.11.92+ 
	# seems to be broken for this package
	elibtoolize

	local myconf
	
	myconf="--disable-mmx"

	econf \
		--sysconfdir=/etc/X11/imlib \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc/X11/imlib install || die
	preplib /usr
	dodoc AUTHORS COPYING* ChangeLog README
	dohtml -r doc
}
