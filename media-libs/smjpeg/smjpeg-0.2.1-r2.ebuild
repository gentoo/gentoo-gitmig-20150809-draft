# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/smjpeg/smjpeg-0.2.1-r2.ebuild,v 1.2 2001/04/29 18:42:54 achim Exp $

P=smjpeg-0.2.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="SDL Motion JPEG Library"
SRC_URI="ftp://ftp.linuxgames.com/loki/open-source/smjpeg/${A}"
HOMEPAGE="http://www.lokigames.com/development/smjpeg.php3"

DEPEND=">=media-libs/libsdl-1.1.7"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc CHANGES COPYING README TODO SMJPEG.txt

}


