# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-20010601-r1.ebuild,v 1.4 2002/07/08 04:47:38 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A Qt Interface for coin"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${A}"
HOMEPAGE="http://www.coinn3d.org"

DEPEND="virtual/x11 virtual/opengl =x11-libs/qt-2.3* =media-libs/coin-${PV}*"

src_compile() {

    ./configure --prefix=/usr --host=${CHOST} --build=${CHOST} --qith-qt-dir=/usr/qt/2 || die
    make || die

}

src_install () {

    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog* LICENSE* NEWS README*
    docinto txt
    dodoc docs/qtcomponents.doxygen

}

