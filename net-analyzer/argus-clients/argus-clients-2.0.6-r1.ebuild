# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/argus-clients/argus-clients-2.0.6-r1.ebuild,v 1.2 2007/03/31 15:58:35 vanquirius Exp $

inherit eutils

DESCRIPTION="Clients for net-analyzer/argus"
HOMEPAGE="http://www.qosient.com/argus/"
SRC_URI="ftp://ftp.qosient.com/pub/argus/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/libc
	net-libs/libpcap
	>=net-analyzer/argus-2.0.6
	net-analyzer/rrdtool"

DEPEND="${RDEPEND}
	>=sys-devel/bison-1.28
	>=sys-devel/flex-2.4.6"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix from bug #143290
	epatch "${FILESDIR}"/${P}-netmask.patch || die "patch failed"
}

src_install() {
	# argus_parse.a and argus_common.a are supplied by net-analyzer/argus
	dolib lib/argus_client.a || die "Failed to process argus_client.a"
	dobin bin/ra* || die "Failed to install ra*"

	dodoc ChangeLog CREDITS README

	#do not install man/man1/tcpdump.1, file collision
	rm man/man1/tcpdump.1
	doman man/man{1,5}/*
}
