# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bird/bird-1.1.6.ebuild,v 1.1 2009/11/23 14:35:04 chainsaw Exp $

inherit eutils

DESCRIPTION="A routing daemon implementing OSPF, RIPv2 & BGP for IPv4 or IPv6"
HOMEPAGE="http://bird.network.cz"
SRC_URI="ftp://bird.network.cz/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE="debug ipv6"

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
		$(use_enable debug) \
		$(use_enable ipv6) \
		|| die "Configuration stage failed"
	emake || die "Compilation stage failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	if use ipv6; then
		# The only thing worse then not supplying
		# a sample configuration file to a user is
		# wasting his/her time with a totally
		# broken one.
		rm "${D}/etc/bird6.conf"
		newinitd "${FILESDIR}/initd-v6-${P}" bird6
	else
		newinitd "${FILESDIR}/initd-v4-${P}" bird
	fi
}

pkg_postinst() {
	if use ipv6; then
		elog "Please note that only the IPv6 versions of the BIRD client & daemon have been installed."
	else
		elog "Please note that only the IPv4 versions of the BIRD client & daemon have been installed."
	fi
	elog "BIRDs build system is not currently suited to providing both."
}
