# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/net-misc/gift/gift-0.10.0_pre020527.ebuild,v 1.1 2002/05/30 20:45:58 verwilst Exp

S=${WORKDIR}/giFT
DESCRIPTION="Lets you connect to OpenFT, a decentralised p2p network like FastTrack"
SRC_URI="http://wideview.33lc0.net/gift/giFT-020611.tgz"
HOMEPAGE="http://gift.sourceforge.net"
SLOT="0"

DEPENDS="virtual/glibc
	>=sys-libs/zlib-1.1.4"

src_compile() {

	cd ${S}
	./autogen.sh --prefix=/usr --host=${CHOST} || die
	emake || die

}

src_install() {

	einstall plugindir=${D}/usr/lib/giFT giftdatadir=${D}/usr/share/giFT giftperldir=${D}/usr/bin || die

}
