# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-0.59r.ebuild,v 1.7 2002/07/11 06:30:41 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Real Time mp3 player"
SRC_URI="http://www.mpg123.de/mpg123/${P}.tar.gz"
HOMEPAGE="http://www.mpg123.de/"

DEPEND="virtual/glibc"

src_unpack () {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2 -m486:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {

	make linux-i486 || die

}

src_install () {

	into /usr
	dobin mpg123
	doman mpg123.1
	dodoc BENCHMARKING BUGS CHANGES COPYING JUKEBOX README* TODO


}
