# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Download Apllication for KDE2 based on wget"
SRC_URI="http://download.sourceforge.net/kmago/${A}"
HOMEPAGE="http://kmago.sourceforge.net"

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

