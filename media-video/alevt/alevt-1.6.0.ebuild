# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# Maintainer: First Last <your email>
# $Header: /var/cvsroot/gentoo-x86/media-video/alevt/alevt-1.6.0.ebuild,v 1.1 2002/04/23 15:52:01 verwilst Exp $ 

S=${WORKDIR}/${P}

DESCRIPTION="Teletext viewer for X11"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/video/${P}.tar.gz"
HOMEPAGE="http://"
SLOT="0"
DEPEND="virtual/glibc
    >=media-libs/libpng-1.0.12
    >=x11-base/xfree-4.0.1"

src_unpack() {

    unpack ${P}.tar.gz
    cd ${S}
    patch -p1 < ${FILESDIR}/${PF}-alevt-date.diff
    patch -p1 < ${FILESDIR}/${PF}-makefile.diff

}

src_compile() {

    emake || die

}

src_install () {

	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/man/man1
	mkdir -p ${D}/usr/include/X11/pixmaps

	install -m 0755 alevt           ${D}/usr/bin
        install -m 0755 alevt-date      ${D}/usr/bin
        install -m 0755 alevt-cap       ${D}/usr/bin
        install -m 0644 alevt.1x        ${D}/usr/man/man1
        install -m 0644 alevt-date.1    ${D}/usr/man/man1
        install -m 0644 alevt-cap.1     ${D}/usr/man/man1
        install -m 0644 contrib/mini-alevt.xpm ${D}/usr/include/X11/pixmaps

        sync	

}
