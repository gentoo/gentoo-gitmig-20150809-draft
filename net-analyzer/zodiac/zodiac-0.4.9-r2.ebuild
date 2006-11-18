# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zodiac/zodiac-0.4.9-r2.ebuild,v 1.1 2006/11/18 14:06:02 cedk Exp $

inherit eutils toolchain-funcs

DESCRIPTION="DNS protocol analyzer"
HOMEPAGE="http://www.packetfactory.net/projects/zodiac/"
SRC_URI="http://www.packetfactory.net/projects/zodiac/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-libs/ncurses
	<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3
	net-libs/libpcap"

S=${WORKDIR}/${PN}
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
	sed -i \
		-e "s:-g -ggdb -DDEBUG:${CFLAGS}:" \
		-e 's:-static::' \
		Makefile
	epatch "${FILESDIR}/${P}-dns-spoof-int.patch"
	epatch "${FILESDIR}/${P}-gcc-4.patch"
}

src_compile() {
	cd src
	emake CC=$(tc-getCC) || die
}

src_install() {
	dobin zodiac
	mv README{,.dev}
	dodoc README.dev doc/*
}
