# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Felix Kurth <felix@fkurth.de>
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3c/mp3c-0.27.ebuild,v 1.1 2002/06/21 21:51:26 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="console based mp3 ripper, with cddb support"
HOMEPAGE="http://mp3c.wspse.de/WSPse/Linux-MP3c.php3?lang=en"
LICENSE="GPL­2"
SRC_URI="ftp://excelsior.kullen.rwth-aachen.de/pub/linux/wspse/${P}.tar.gz"
DEPEND=">=media-sound/bladeenc-0.94.2 \
	>=media-sound/cdparanoia-3.9.8 \
	>=media-sound/mp3info-0.8.4-r1"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc ABOUT-NLS AUTHORS BATCH.README BUGS CDDB_HOWTO COPYING ChangeLog FAQ INSTALL NEWS OTHERS README TODO          
}
