# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xl2tpd/xl2tpd-1.3.1.ebuild,v 1.1 2012/09/10 19:28:12 darkside Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A modern version of the Layer 2 Tunneling Protocol (L2TP) daemon"
HOMEPAGE="http://www.xelerance.com/services/software/xl2tpd/"
SRC_URI="https://github.com/xelerance/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dnsretry"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}
	net-dialup/ppp"

S="${WORKDIR}/xelerance-${PN}-95445fc"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.3.0-LDFLAGS.patch"
	sed -i Makefile -e 's| -O2 ||g' || die "sed Makefile"
	use dnsretry && epatch "${FILESDIR}/${PN}-dnsretry.patch"
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install

	dodoc CREDITS README.xl2tpd BUGS CHANGES TODO doc/README.patents doc/rfc2661.txt

	dodir /etc/xl2tpd
	cp doc/l2tp-secrets.sample "${ED}/etc/xl2tpd/l2tp-secrets" || die
	cp doc/l2tpd.conf.sample "${ED}/etc/xl2tpd/xl2tpd.conf" || die
	fperms 0600 /etc/xl2tpd/l2tp-secrets
	newinitd "${FILESDIR}"/xl2tpd-init-r1 xl2tpd
}
