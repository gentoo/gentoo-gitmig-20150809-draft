# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.1.2.1.ebuild,v 1.10 2004/10/23 07:50:07 mr_bones_ Exp $

inherit gnuconfig

DESCRIPTION="library to provide an API for commonly used low-level network functions (mainly packet injection)"
HOMEPAGE="http://www.packetfactory.net/libnet/"
SRC_URI="http://www.packetfactory.net/libnet/dist/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="1.1"
KEYWORDS="alpha arm amd64 hppa ia64 mips ppc ppc-macos sparc x86"
IUSE=""

S=${WORKDIR}/libnet

src_compile() {
	cd ${S}

	# Detect mips systems properly
	gnuconfig_update

	econf || die "Failed to run econf!"
	emake || die "Failed to run emake!"
}

src_install(){
	make DESTDIR=${D} install || die "Failed to install"
	dobin libnet-config || die

	doman doc/man/man3/*.3
	dodoc VERSION README doc/*
	dohtml -r doc/html/*
	docinto sample ; dodoc sample/*.[ch]
}
