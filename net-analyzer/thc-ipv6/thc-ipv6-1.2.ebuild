# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/thc-ipv6/thc-ipv6-1.2.ebuild,v 1.1 2010/09/15 01:49:58 xmw Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="complete tool set to attack the inherent protocol weaknesses of IPV6 and ICMP6"
HOMEPAGE="http://freeworld.thc.org/thc-ipv6/"
SRC_URI="http://freeworld.thc.org/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-libs/libpcap
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	rm Makefile || die
	cp "${FILESDIR}"/${P}-Makefile Makefile || die

	epatch "${FILESDIR}"/${P}-header.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die

	dodoc CHANGES README || die
}
