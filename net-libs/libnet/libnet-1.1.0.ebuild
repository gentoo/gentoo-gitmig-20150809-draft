# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.1.0.ebuild,v 1.1 2002/08/27 17:11:37 aliz Exp $

S=${WORKDIR}/Libnet-latest
DESCRIPTION="library to provide an API for commonly used low-level network
functions (mainly packet injection). Used by packet scrubbers and the like,
not to be confused with the perl libnet"
SRC_URI="http://www.packetfactory.net/libnet/dist/${P}.tar.gz"
HOMEPAGE="http://www.packetfactory.net/libnet/"
DEPEND=""

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"

src_compile() {

	econf || die
	
	emake || die
}

src_install () {
	
	make \
		DESTDIR=${D} \
		MAN_PREFIX=${D}/usr/share/man \
		install || die

	dodoc VERSION README doc/{CHANGELOG,COPYING,DESIGN_NOTES,PACKET_BUILDING}
	dodoc doc/{RAWSOCKET_NON_SEQUITUR,TODO,BUGS,CONTRIB,MIGRATION,PORTED,SUPPORTED_PROTOCOLS}
	docinto Ancillary
	dodoc doc/Ancillary/README*
}

