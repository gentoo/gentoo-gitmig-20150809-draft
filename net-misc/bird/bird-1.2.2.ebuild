# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bird/bird-1.2.2.ebuild,v 1.1 2010/04/12 11:58:59 chainsaw Exp $

inherit eutils autotools

DESCRIPTION="A routing daemon implementing OSPF, RIPv2 & BGP for IPv4 or IPv6"
HOMEPAGE="http://bird.network.cz"
SRC_URI="ftp://bird.network.cz/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="sys-libs/ncurses
	sys-libs/readline
	${DEPEND}"
DEPEND="sys-devel/flex
	sys-devel/bison
	sys-devel/m4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-v4-v6-build.patch"
	eautoreconf
}

src_compile() {
	econf \
		--enable-client \
		--disable-ipv6 \
		$(use_enable debug) \
		|| die "V4 configuration stage failed"
	emake || die "V4 compilation stage failed"
}

src_install() {
	emake DESTDIR="${D}" install-bin || die "V4 installation stage failed"
	newinitd "${FILESDIR}/initd-v4-${P}" bird || die "V4 init script installation failed"
}
