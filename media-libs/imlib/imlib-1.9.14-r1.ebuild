# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.14-r1.ebuild,v 1.3 2002/07/16 11:36:47 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Imlib is a general Image loading and rendering library."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz
	 http://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz
	 ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	>=media-libs/tiff-3.5.5
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.2.1
	 >=media-libs/jpeg-6b"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc"

src_compile() {
	
	elibtoolize

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--includedir="" \
		--infodir=/usr/share/info \
		--sysconfdir=/etc/imlib || die
		
	emake || die
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		includedir=${D}/usr/include \
		sysconfdir=${D}/etc/imlib \
		install || die

	preplib /usr

	dodoc AUTHORS COPYING* ChangeLog README
	dodoc NEWS
	dohtml -r doc
}
