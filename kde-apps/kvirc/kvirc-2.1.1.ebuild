# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A IRC Client for KDE"
SRC_URI="ftp://ftp.kvirc.net/kvirc/2.1.1/source/${A}"
HOMEPAGE="http://www.kvirc.net"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-libs/qt-x11-2.3"

src_compile() {

    cd ${S}
    try ./configure --with-kde-support
    try make kvirc

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    try make DESTDIR=${D} docs
   		
}



