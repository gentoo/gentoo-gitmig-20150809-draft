# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Michael Nazaroff <naz@themoonsofjupiter.net>
# /home/cvsroot/gentoo-x86/media-video/xmps-opendivx/xmps-opendivx-plugin-0.0.2.ebuild,v 1

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Divx Plugin for XMPS"
SRC_URI="http://xmps.sourceforge.net/sources/${A}"
HOMEPAGE="http://xmps.sourceforge.net"

DEPEND=">=media-video/xmps-0.2.0"

RDEPEND=">=media-video/xmps-0.2.0"

src_compile() {

    try ./configure --host=${CHOST} --prefix=/usr

	 make || die

}

src_install () {

    #try make prefix=${D}/usr/lib install
	make DESTDIR=${D} install || die

    dodoc AUTHORS ChangeLog COPYING NEWS README TODO

}
