# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.1.0-r1.ebuild,v 1.5 2003/04/23 00:12:05 lostlogic Exp $

S=${WORKDIR}/Libnet-latest
DESCRIPTION="library to provide an API for commonly used low-level network
functions (mainly packet injection). Used by packet scrubbers and the like,
not to be confused with the perl libnet"
SRC_URI="http://www.packetfactory.net/${PN}/dist/${P}.tar.gz"
HOMEPAGE="http://www.packetfactory.net/libnet/"

DEPEND="=sys-apps/sed-4*"

SLOT="1.1"
LICENSE="LGPL-2"
KEYWORDS="x86 ~alpha"

src_compile(){
	econf \
		--libdir=/usr/lib/libnet-${PV} \
		--includedir=/usr/include/libnet-${PV} \
		--program-suffix=-${PV} \
		|| die

	emake || die "Failed to compile"
}

src_install(){
	make DESTDIR=${D} install || die "Failed to install"

	sed -i "s/libnet-config/&-${PV}/" libnet-config
	exeinto /usr/bin 
	newexe libnet-config libnet-config-${PV}

	dodoc VERSION README doc/*
	docinto Ancillary ; dodoc doc/Ancillary/README*
	docinto sample ; dodoc sample/*.[ch]
}

pkg_postinst(){
	echo
	einfo "config script for libnet version ${PV} is libnet-config-${PV}"
	einfo "manpage for libnet version ${PV} is libnet-${PV}"
	echo
}
