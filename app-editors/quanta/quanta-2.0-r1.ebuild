# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}-pr1.tar.bz2
S=${WORKDIR}/quanta
DESCRIPTION="HTML editor for KDE2"
SRC_URI="http://ftp1.sourceforge.net/quanta/${A}"
HOMEPAGE="http://quanta.sourceforge.net"

DEPEND=">=kde-base/kdelibs-2.1.1"

RDEPEND=$DEPEND

src_compile() {

    try ./configure --prefix=${KDEDIR} --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

