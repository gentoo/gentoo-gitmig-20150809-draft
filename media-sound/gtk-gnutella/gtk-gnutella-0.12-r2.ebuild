# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtk-gnutella/gtk-gnutella-0.12-r2.ebuild,v 1.1 2000/11/21 16:17:41 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A GTk gnutella Client"
SRC_URI="ftp://${PN}.sourceforge.net/pub/${PN}/${A}"
HOMEPAGE="http://${PN}.sourceforge.net/"

DEPEND=">=x11-libs/gtk+-1.2.8"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}


