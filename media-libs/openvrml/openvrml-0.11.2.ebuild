# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openvrml/openvrml-0.11.2.ebuild,v 1.17 2006/05/12 23:00:31 tcort Exp $

IUSE="jpeg png"

DESCRIPTION="VRML97 library"
SRC_URI="mirror://sourceforge/openvrml/${P}.tar.gz"
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
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
