# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg/smpeg-0.4.1.ebuild,v 1.2 2000/10/04 16:04:34 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="SDL MPEG Player Library"
SRC_URI="ftp://ftp.lokigames.com/pub/open-source/smpeg/${A}"
HOMEPAGE="http://www.lokigames.com/development/smpeg.php3"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --disable-opengl-player
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
   prepman
   dodoc CHANGES COPYING README* TODO
}




