# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# Maintainer: Desktop Team <desktop@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoGtk/SoGtk-20010601-r1.ebuild,v 1.4 2002/06/20 20:41:27 azarah Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A Gtk Interface for coin"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org"
SLOT="0"

DEPEND="virtual/x11
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	<x11-libs/gtkglarea-1.99.0
	~media-libs/coin-${PV}"

RDEPEND="virtual/x11
	<x11-libs/gtkglarea-1.99.0
	~media-libs/coin-${PV}"

src_compile() {

    ./bootstrap --add

    ./configure --prefix=/usr \
		--host=${CHOST} \
		--build=${CHOST} || die
	
    make || die
}

src_install () {
    
    make prefix=${D}/usr install || die
	
    cd ${S}
    dodoc AUTHORS COPYING ChangeLog* LICENSE* NEWS README*
    docinto txt
    dodoc docs/qtcomponents.doxygen
}

