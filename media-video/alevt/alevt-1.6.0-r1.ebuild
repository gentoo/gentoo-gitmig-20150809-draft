# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-video/alevt/alevt-1.6.0-r1.ebuild,v 1.1 2002/06/29 02:40:07 seemant Exp $ 

S=${WORKDIR}/${P}

DESCRIPTION="Teletext viewer for X11"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/video/${P}.tar.gz"
HOMEPAGE="http://"
SLOT="0"
DEPEND="virtual/glibc
    >=media-libs/libpng-1.0.12
    >=x11-base/xfree-4.0.1"

LICENSE="GPL-2"

src_unpack() {

    unpack ${P}.tar.gz
    cd ${S}
    patch -p1 < ${FILESDIR}/${P}-alevt-date.diff
    patch -p1 < ${FILESDIR}/${P}-makefile.diff

}

src_compile() {
	
	# emake doesn't work well
    make || die

}

src_install () {

	DMANDIR=${D}/usr/share/man/man1
	DBINDIR=${D}/usr/bin

	mkdir -p ${DBINDIR}
	mkdir -p ${DMANDIR}
	mkdir -p ${D}/usr/include/X11/pixmaps

	install -m 0755 alevt ${DBINDIR}
	install -m 0755 alevt-date ${DBINDIR}
	install -m 0755 alevt-cap ${DBINDIR}
	install -m 0644 alevt.1x ${DMANDIR}
	install -m 0644 alevt-date.1 ${DMANDIR}
	install -m 0644 alevt-cap.1 ${DMANDIR}
	install -m 0644 contrib/mini-alevt.xpm ${D}/usr/include/X11/pixmaps

	sync	
	
}
