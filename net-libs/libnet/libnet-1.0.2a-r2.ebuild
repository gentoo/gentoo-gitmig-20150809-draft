# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.0.2a-r2.ebuild,v 1.7 2003/05/23 09:58:13 taviso Exp $

S=${WORKDIR}/Libnet-1.0.2a
DESCRIPTION="library to provide an API for commonly used low-level network
functions (mainly packet injection). Used by packet scrubbers and the like,
not to be confused with the perl libnet"
SRC_URI="http://www.packetfactory.net/${PN}/dist/${PN}.tar.gz"
HOMEPAGE="http://www.packetfactory.net/${PN}/"

DEPEND=""

SLOT="1.0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc arm alpha"

src_compile(){
	econf || die
	emake CFLAGS="${CFLAGS}" || die "Failed to compile"
}

src_install () {
	einstall \
		MAN_PREFIX=${D}/usr/share/man/man3 || die

	dodoc VERSION doc/{README,TODO*,CHANGELOG*,COPYING}
	newdoc README README.1st
	docinto example ; dodoc example/libnet*
	docinto Ancillary ; dodoc doc/Ancillary/*
}
