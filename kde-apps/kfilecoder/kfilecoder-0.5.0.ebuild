# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Archiver with passwd management "
SRC_URI="http://download.sourceforge.net/kfilecoder/${A}"
HOMEPAGE="http://kfilecoder.sourceforge.net"

DEPEND=">=kde-base/kde-2.0"

RDEPEND=$DEPEND

src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/kde2.1 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

