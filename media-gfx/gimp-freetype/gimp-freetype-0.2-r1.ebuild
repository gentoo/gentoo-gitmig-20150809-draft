# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-freetype/gimp-freetype-0.2-r1.ebuild,v 1.2 2002/07/11 06:30:27 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GIMP freetype text plugin"
SRC_URI="http://freetype.gimp.org/gimp-freetype-0.2.tar.gz"
HOMEPAGE="http://freetype.gimp.org/"

DEPEND=">=media-gfx/gimp-1.2.3-r1 >=media-libs/freetype-2.0.1"
RDEPEND="virtual/glibc"


src_compile() {
	./configure --host=${CHOST} \
	--prefix=/usr \
	--mandir=/usr/share/man \
	--infodir=/usr/share/info \
	--sysconfdir=/etc/gimp/1.2/	\
	--with-gimp-exec-prefix=/usr \
	|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} prefix=${D}/usr\
	install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README* TODO
}

