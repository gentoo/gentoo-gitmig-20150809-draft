# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openvrml/openvrml-0.11.2.ebuild,v 1.12 2003/09/06 23:59:48 msterret Exp $

IUSE="jpeg png"

S=${WORKDIR}/${P}
DESCRIPTION="VRML97 library"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/openvrml/${P}.tar.gz"
HOMEPAGE="http://openvrml.org"

SLOT="0"
LICENSE="LGPL-2.1 GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/opengl
	sys-libs/zlib
	media-libs/glut
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )"

# TODO: add support for java via libmozjs (http://www.mozilla.org/js/spidermonkey/)

src_compile() {

	use png \
		&& myconf="${myconf} --with-libpng" \
		|| myconf="${myconf} --without-libpng"

	use jpeg \
		&& myconf="${myconf} --with-libjpeg" \
		|| myconf="${myconf} --without-libjpeg"

	./configure --with-x --prefix=/usr --without-mozjs ${myconf} || die

	make || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README THANKS

}
