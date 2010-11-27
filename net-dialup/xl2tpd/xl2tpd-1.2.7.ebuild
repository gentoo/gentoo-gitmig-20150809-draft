# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xl2tpd/xl2tpd-1.2.7.ebuild,v 1.1 2010/11/27 11:01:36 mrness Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A modern version of the Layer 2 Tunneling Protocol (L2TP) daemon"
HOMEPAGE="http://www.xelerance.com/software/"
SRC_URI="ftp://ftp.xelerance.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dnsretry"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}
	net-dialup/ppp"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch
	epatch "${FILESDIR}"/${P}-qa-fixes.patch
	use dnsretry && epatch "${FILESDIR}"/${PN}-dnsretry.patch
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install || die "emake install failed"

	dodoc CREDITS README.xl2tpd \
		doc/README.patents doc/rfc2661.txt doc/*.sample

	dodir /etc/xl2tpd
	head -n 2 doc/l2tp-secrets.sample > "${D}/etc/xl2tpd/l2tp-secrets"
	fperms 0600 /etc/xl2tpd/l2tp-secrets
	newinitd "${FILESDIR}"/xl2tpd-init xl2tpd

	keepdir /var/run/xl2tpd
}
