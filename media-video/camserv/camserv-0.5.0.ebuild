# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/camserv/camserv-0.5.0.ebuild,v 1.2 2002/07/11 06:30:42 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A streaming video server."
SRC_URI="http://cserv.sourceforge.net/current/${P}.tar.gz"
HOMEPAGE="http://cserv.sourceforge.net/"
LICENSE="GPL-2"

DEPEND=">=media-libs/jpeg-6b-r2
		>=media-libs/imlib-1.9.13-r2"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die

	emake || die
	#make || die

}

src_install () {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO javascript.txt
	dohtml defpage.html

}
