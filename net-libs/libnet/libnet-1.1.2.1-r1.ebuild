# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.1.2.1-r1.ebuild,v 1.1 2005/03/23 00:54:50 vapier Exp $

inherit eutils

DESCRIPTION="library to provide an API for commonly used low-level network functions (mainly packet injection)"
HOMEPAGE="http://www.packetfactory.net/libnet/"
SRC_URI="http://www.packetfactory.net/libnet/dist/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="1.1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~s390 ~sh ~sparc ~x86"
IUSE="doc"

DEPEND="sys-devel/autoconf"
RDEPEND=""

S=${WORKDIR}/libnet

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-chksum.patch
	epatch "${FILESDIR}"/${P}-autotools.patch
	libtoolize --copy --force && \
	aclocal && \
	autoconf && \
	automake || die "autotools failed"
}

src_install(){
	make DESTDIR="${D}" install || die "Failed to install"

	doman doc/man/man3/*.3
	dodoc VERSION README doc/*
	if use doc ; then
		dohtml -r doc/html/*
		docinto sample
		dodoc sample/*.[ch]
	fi
}
