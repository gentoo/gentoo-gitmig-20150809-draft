# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.0.1-r1.ebuild,v 1.1 2001/08/29 20:04:08 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A fast, lightweight imageviewer using imlib2"
SRC_URI="http://www.linuxbrit.co.uk/downloads/feh-1.0.1.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/feh"

DEPEND="media-libs/imlib2"

src_compile() {

    ./configure --prefix=/usr/X11R6 --infodir=/usr/share/info --host=${CHOST}
    assert
    emake || die
}

src_install () {

    make DESTDIR=${D} install || die
    rm -rf ${D}/usr/X11R6/doc
    dodoc AUTHORS COPYING ChangeLog README TODO
}

