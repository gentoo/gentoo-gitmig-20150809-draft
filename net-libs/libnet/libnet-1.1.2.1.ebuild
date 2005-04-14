# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.1.2.1.ebuild,v 1.13 2005/04/14 03:43:17 tgall Exp $

DESCRIPTION="library to provide an API for commonly used low-level network functions (mainly packet injection)"
HOMEPAGE="http://www.packetfactory.net/libnet/"
SRC_URI="http://www.packetfactory.net/libnet/dist/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="1.1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos sparc x86 ppc64"
IUSE="doc"

S=${WORKDIR}/libnet

src_install(){
	make DESTDIR="${D}" install || die "Failed to install"
	dobin libnet-config || die

	doman doc/man/man3/*.3
	dodoc VERSION README doc/*
	if use doc ; then
		dohtml -r doc/html/*
		docinto sample
		dodoc sample/*.[ch]
	fi
}
