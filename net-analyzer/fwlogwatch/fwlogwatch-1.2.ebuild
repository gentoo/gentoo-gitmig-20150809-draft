# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fwlogwatch/fwlogwatch-1.2.ebuild,v 1.1 2010/11/30 21:02:52 jer Exp $

EAPI="2"

inherit toolchain-funcs eutils

DESCRIPTION="A packet filter and firewall log analyzer"
HOMEPAGE="http://fwlogwatch.inside-security.de/"
SRC_URI="${HOMEPAGE}sw/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-1"
SLOT="0"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.1-make.patch"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dosbin fwlogwatch
	dosbin contrib/fwlw_notify
	dosbin contrib/fwlw_respond
	dodir /usr/share/fwlogwatch/contrib
	insinto /usr/share/fwlogwatch/contrib

	doins contrib/fwlogsummary.cgi
	doins contrib/fwlogsummary_small.cgi
	doins contrib/fwlogwatch.php
	doins contrib

	insinto /etc
	doins fwlogwatch.config

	dodoc AUTHORS ChangeLog CREDITS README
	doman fwlogwatch.8
}
