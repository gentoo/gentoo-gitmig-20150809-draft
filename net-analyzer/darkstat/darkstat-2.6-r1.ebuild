# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/darkstat/darkstat-2.6-r1.ebuild,v 1.10 2006/10/31 13:31:00 pva Exp $

inherit eutils

DESCRIPTION="darkstat is a network traffic analyzer"
HOMEPAGE="http://dmr.ath.cx/net/darkstat/"
SRC_URI="http://dmr.ath.cx/net/darkstat/${P}.tar.gz"

KEYWORDS="x86 ~ppc ppc-macos ~amd64"
IUSE="nls"
LICENSE="GPL-2"
SLOT="0"

DEPEND="net-libs/libpcap
	nls? ( virtual/libintl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/ipcheck.patch
}

src_compile() {
	econf $(use_with nls) || die "./configure failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	keepdir /var/spool/darkstat

	dodoc AUTHORS ChangeLog ISSUES README

	newinitd "${FILESDIR}"/darkstat-init darkstat
	newconfd "${FILESDIR}"/darkstat-confd darkstat
}

