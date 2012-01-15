# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libircclient/libircclient-1.3.ebuild,v 1.1 2012/01/15 00:48:37 mr_bones_ Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Small but powerful library implementing the client-server IRC protocol"
HOMEPAGE="http://libircclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/libircclient/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc ipv6 threads"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoconf
}

src_configure() {
	econf \
		$(use_enable ipv6) \
		$(use_enable threads thread)
}

src_compile() {
	emake -C src
}

src_install() {
	insinto /usr/include/libircclient
	doins include/*.h
	dolib src/libircclient.a

	dodoc Changelog THANKS
	if use doc ; then
		doman doc/man/man3/*
		dohtml doc/html/*
	fi
}
