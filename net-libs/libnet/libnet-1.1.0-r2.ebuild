# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.1.0-r2.ebuild,v 1.1 2003/08/16 23:01:32 vapier Exp $

DESCRIPTION="library to provide an API for commonly used low-level network functions (mainly packet injection)"
HOMEPAGE="http://www.packetfactory.net/libnet/"
SRC_URI="http://www.packetfactory.net/${PN}/dist/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="1.1"
KEYWORDS="x86 alpha"

DEPEND="=sys-apps/sed-4*"

S=${WORKDIR}/Libnet-latest

src_compile(){
	econf \
		--libdir=/usr/lib/libnet-${SLOT} \
		--includedir=/usr/include/libnet-${SLOT} \
		--program-suffix=-${SLOT} \
		|| die
	emake || die "Failed to compile"
}

src_install(){
	make DESTDIR=${D} install || die "Failed to install"

	dodoc VERSION README doc/*
	docinto Ancillary ; dodoc doc/Ancillary/README*
	docinto sample ; dodoc sample/*.[ch]

	sed -i "s/libnet-config/&-${SLOT}/" libnet-config
	newbin libnet-config libnet-config-${SLOT}
	cd ${D}/usr/lib
	mv libnet-${SLOT}/libnet.a libnet${SLOT}.a
	rm -rf libnet-${SLOT}
}

pkg_postinst(){
	echo
	einfo "config script for libnet version ${SLOT} is libnet-config-${SLOT}"
	einfo "manpage for libnet version ${SLOT} is libnet-${SLOT}"
	echo
}
