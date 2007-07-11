# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/argus/argus-2.0.5.ebuild,v 1.15 2007/07/11 23:49:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="network Audit Record Generation and Utilization System"
HOMEPAGE="http://www.qosient.com/argus/"

SRC_URI="ftp://ftp.qosient.com/pub/argus/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos x86"
IUSE=""
RDEPEND="virtual/libc
	net-libs/libpcap"
DEPEND="${RDEPEND}
	>=sys-devel/bison-1.28
	>=sys-devel/flex-2.4.6"

src_unpack() {
	unpack ${A} ; cd "${S}"

	epatch "${FILESDIR}"/${P}-libpcap-include.patch

	# Fix hardcoded config file
	epatch "${FILESDIR}"/${PF}-gentoo.diff
}

src_install () {
	dodoc CREDITS README doc/{FAQ,HOW-TO,CHANGES}

	#do not install man/man1/tcpdump.1, file collision
	doman man/man1/ra* man/man5/* man/man8/*

	dolib lib/argus_common.a lib/argus_parse.a

	dobin bin/ra*

	use ppc-macos && newsbin bin/argus_bpf argus || newsbin bin/argus_linux argus

	insinto /etc/argus
	doins support/Config/argus.conf
}
