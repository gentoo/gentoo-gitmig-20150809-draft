# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/smjpeg/smjpeg-0.2.1-r2.ebuild,v 1.5 2002/04/27 11:45:30 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SDL Motion JPEG Library"
SRC_URI="ftp://ftp.linuxgames.com/loki/open-source/smjpeg/${P}.tar.gz"
HOMEPAGE="http://www.lokigames.com/development/smjpeg.php3"

DEPEND=">=media-libs/libsdl-1.1.7"

src_compile() {
	use nas && LDFLAGS="-L/usr/X11R6/lib -lXt"
		
	LDFLAGS="$LDFLAGS" ./configure --prefix=/usr --host=${CHOST}
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING README TODO SMJPEG.txt

}
