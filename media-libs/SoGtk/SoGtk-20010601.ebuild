# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoGtk/SoGtk-20010601.ebuild,v 1.2 2001/06/09 14:11:57 achim Exp $


A=${P}.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="A Qt Interface for coin"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${A}"
HOMEPAGE="http://www.coin3d.org"

DEPEND="virtual/x11 sys-devel/autoconf sys-devel/automake sys-devel/libtool
	>=x11-libs/gtkglarea-1.2.2
        =media-libs/coin-${PV}"

RDEPEND="virtual/x11
	>=x11-libs/gtkglarea-1.2.2
        =media-libs/coin-${PV}"
src_compile() {

    ./bootstrap --add

    try ./configure --prefix=/usr/X11R6 --host=${CHOST} --build=${CHOST}
    try make

}

src_install () {
    
    try make DESTDIR=${D} install
    cd ${S}
    dodoc AUTHORS COPYING ChangeLog* LICENSE* NEWS README*
    docinto txt
    dodoc docs/qtcomponents.doxygen

}

