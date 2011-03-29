# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/thc-ipv6/thc-ipv6-1.4.ebuild,v 1.2 2011/03/29 04:14:07 vapier Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="complete tool set to attack the inherent protocol weaknesses of IPV6 and ICMP6"
HOMEPAGE="http://freeworld.thc.org/thc-ipv6/"
SRC_URI="http://freeworld.thc.org/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libpcap
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die

	dodoc CHANGES README || die
}
