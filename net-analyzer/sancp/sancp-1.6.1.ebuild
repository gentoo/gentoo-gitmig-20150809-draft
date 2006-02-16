# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sancp/sancp-1.6.1.ebuild,v 1.2 2006/02/15 23:50:15 jokey Exp $

inherit eutils

DESCRIPTION="SANCP is a network security tool designed to collect statistical \
	information regarding network traffic and collect the traffic itself in pcap format."
HOMEPAGE="http://www.metre.net/sancp.html"
SRC_URI="http://www.metre.net/files/${P}.tar.gz"

LICENSE="QPL"

SLOT="0"
KEYWORDS="~x86"

IUSE="sguil"

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup sancp
	enewuser sancp -1 -1 /dev/null sancp
}

src_install() {
	keepdir /var/log/sancp/
	dodoc docs/CHANGES docs/fields.LIST docs/README docs/SETUP \
		${FILESDIR}/sguil_sancp.conf etc/sancp/sancp.conf

	insinto /etc/sancp
	if use sguil ; then
		newins ${FILESDIR}/sguil_sancp.conf sancp.conf
	else
		doins etc/sancp/sancp.conf
	fi

	exeinto /usr/bin
	doexe sancp

	newinitd ${FILESDIR}/sancp.rc1 sancp
	newconfd ${FILESDIR}/sancp.confd sancp
	if use sguil ; then
		sed -i -e /^SANCP_OPTS/s:'sancp':"sguil":g \
			-e s:'-d $LOGDIR/today':"-d /var/lib/sguil/$(hostname)/sancp": \
			"${D}/etc/conf.d/sancp"
	fi

	fowners sancp:sancp /var/log/sancp
	fperms 0770 /var/log/sancp
}

pkg_postinst() {
	einfo
	einfo "Please modify /etc/sancp/sancp.conf to suit your environment"
	einfo
}
