# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fwlogwatch/fwlogwatch-1.0.ebuild,v 1.2 2004/07/16 09:41:17 dholm Exp $

DESCRIPTION="A packet filter and firewall log analyzer"
HOMEPAGE="http://fwlogwatch.inside-security.de/"
SRC_URI="http://www.kybs.de/boris/sw/${P}.tar.bz2"

KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="GPL-1"
SLOT="0"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s/^CFLAGS = /CFLAGS = ${CFLAGS} /g" Makefile || \
			die "sed Makefile failed"
}

src_compile() {
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

	doins fwlogwatch.config fwlogwatch.template

	dodoc AUTHORS ChangeLog CREDITS COPYING README
	doman fwlogwatch.8
}
