# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xl2tpd/xl2tpd-1.04.ebuild,v 1.1 2006/05/30 20:54:12 mrness Exp $

DESCRIPTION="A modern version of the Layer 2 Tunneling Protocol (L2TP) daemon"
HOMEPAGE="http://www.xelerance.com/software/xl2tpd/"
SRC_URI="http://www.xelerance.com/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!net-dialup/l2tpd
	net-dialup/ppp"

S="${WORKDIR}/xl2tp-${PV}"

src_install() {
	dosbin l2tpd
	doman doc/*.[85]

	dodoc BUGS CHANGELOG CREDITS README TODO \
		doc/rfc2661.txt doc/*.sample

	dodir /etc/l2tpd
	head -n 2 doc/l2tp-secrets.sample > "${D}/etc/l2tpd/l2tp-secrets"
	fperms 0600 /etc/l2tpd/l2tp-secrets

	newinitd "${FILESDIR}/l2tpd-init" l2tpd
}
