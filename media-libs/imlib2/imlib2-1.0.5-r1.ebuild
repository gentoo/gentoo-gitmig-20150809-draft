# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.0.5-r1.ebuild,v 1.2 2002/05/23 06:50:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="imlib"
SRC_URI="http://prdownloads.sourceforge.net/enlightenment/${P}.tar.gz"
HOMEPAGE="http://enlightenment.org/"

DEPEND="virtual/glibc
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.2.1
	>=media-libs/tiff-3.5.5
	<=media-libs/freetype-1.4
	=x11-libs/gtk+-1.2*
	dev-db/edb
	virtual/x11"

src_compile() {
	# always turn off mmx because binutils 2.11.92+ seems to be broken for this package
	myconf="--disable-mmx"
	./configure "${myconf} " --host=${CHOST} --prefix=/usr --sysconfdir=/etc/X11/imlib || die
	emake || die
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc/X11/imlib install || die
	preplib /usr
	dodoc AUTHORS COPYING* ChangeLog README
	dohtml -r doc
}
