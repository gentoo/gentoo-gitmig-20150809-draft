# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift/gift-0.10.0_pre020830.ebuild,v 1.1 2002/09/01 21:42:24 verwilst Exp $

S=${WORKDIR}/giFT
DESCRIPTION="Lets you connect to OpenFT, a decentralised p2p network like FastTrack"
SRC_URI="http://dshieldpy.sourceforge.net/${P}.tgz"
HOMEPAGE="http://gift.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPENDS="virtual/glibc
	zlib? ( >=sys-libs/zlib-1.1.4 )"
	
src_compile() {

	cd ${S}
	./autogen.sh --prefix=/usr --host=${CHOST} || die
	emake || die

}

src_install() {

	einstall giftconfdir=${D}/etc/giFT \
		 plugindir=${D}/usr/lib/giFT \
		 giftdatadir=${D}/usr/share/giFT \
		 giftperldir=${D}/usr/bin || die
	cd ${D}/usr/bin
	mv giFT-setup giFT-setup.orig
	sed 's:$prefix/etc/giFT/:/etc/giFT/:' giFT-setup.orig > giFT-setup
	chmod +x ${D}/usr/bin/giFT-setup

}
