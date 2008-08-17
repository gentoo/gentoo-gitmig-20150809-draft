# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xl2tpd/xl2tpd-1.1.12-r1.ebuild,v 1.2 2008/08/17 15:25:13 maekke Exp $

inherit eutils flag-o-matic

DESCRIPTION="A modern version of the Layer 2 Tunneling Protocol (L2TP) daemon"
HOMEPAGE="http://www.xelerance.com/software/xl2tpd/"
SRC_URI="ftp://ftp.xelerance.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="!net-dialup/l2tpd
	net-dialup/ppp"

src_compile() {
    append-flags -DTRUST_PPPD_TO_DIE
    emake || die "emake failed"
}

src_install() {
	dosbin xl2tpd || die 'xl2tpd binary not found'
	doman doc/*.[85]

	dodoc CREDITS README.xl2tpd \
		doc/README.patents doc/rfc2661.txt doc/*.sample

	dodir /etc/xl2tpd
	head -n 2 doc/l2tp-secrets.sample > "${D}/etc/xl2tpd/l2tp-secrets"
	fperms 0600 /etc/xl2tpd/l2tp-secrets
	newinitd "${FILESDIR}/xl2tpd-init" xl2tpd

	keepdir /var/run/xl2tpd
}
