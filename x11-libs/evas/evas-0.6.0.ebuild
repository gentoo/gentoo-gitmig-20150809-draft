# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/evas/evas-0.6.0.ebuild,v 1.6 2002/08/14 13:05:59 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="OpenGL-accelerated canvas library from the enlightenment project"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.bz2"
HOMEPAGE="http://www.enlightenment.org"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="x11-base/xfree
		=media-libs/freetype-1*
		media-libs/imlib2
		opengl? ( virtual/opengl )"

src_compile() {
	local myconf=""
	
	use opengl || myconf="${myconf} --disable-gl"
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING README FAQ-EVAS doc/evas.pdf
}
