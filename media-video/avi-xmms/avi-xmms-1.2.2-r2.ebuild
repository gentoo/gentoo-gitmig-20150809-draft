# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/avi-xmms/avi-xmms-1.2.2-r2.ebuild,v 1.1 2001/10/06 17:22:51 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A xmms plugin for AVI/DivX movies"
SRC_URI="http://www.xmms.org/files/plugins/avi-xmms/avi-xmms-1.2.2.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

DEPEND=">=media-video/avifile-0.53.5 media-sound/xmms-1.2.5-r1"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST} --disable-sdltest
    try make
}

src_install () {
    try make libdir=/usr/lib/xmms/Input DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README TODO
}

