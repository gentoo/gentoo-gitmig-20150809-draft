# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tracebox/tracebox-0.2.ebuild,v 1.1 2014/06/26 22:09:37 jer Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="A Middlebox Detection Tool"
HOMEPAGE="http://www.tracebox.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-lang/lua
	net-libs/libcrafter[pcap]
	net-libs/libpcap
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${P}-deps.patch

	sed -i -e '/SUBDIRS/s|noinst||g' Makefile.am || die
	sed -i -e '/DIST_SUBDIRS.*libcrafter/d' noinst/Makefile.am || die
	sed -i \
		-e '/[[:graph:]]*libcrafter[[:graph:]]*/d' \
		src/${PN}//Makefile.am || die
	sed -i \
		-e 's|"crafter.h"|<crafter.h>|g' \
		src/tracebox/PacketModification.h \
		src/tracebox/PartialHeader.h \
		src/tracebox/script.h \
		src/tracebox/tracebox.h \
		|| die

	eautoreconf
}
