# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bird/bird-1.1.0.ebuild,v 1.1 2009/07/22 12:20:53 chainsaw Exp $

inherit eutils

DESCRIPTION="A routing daemon implementing OSPF, RIPv2 & BGP for IPv4 or IPv6"
HOMEPAGE="http://bird.network.cz"
SRC_URI="ftp://bird.network.cz/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE="ipv6"

RDEPEND="sys-libs/ncurses
	sys-libs/readline
	${DEPEND}"
DEPEND="sys-devel/flex
	sys-devel/bison
	sys-devel/m4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-nostrip.patch"
}

src_compile() {
	econf \
		--enable-client \
		$(use_enable ipv6) \
		|| die "Configuration stage failed"
	emake -j1 || die "Compilation stage failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	newinitd "${FILESDIR}/initd-${P}" bird
}
