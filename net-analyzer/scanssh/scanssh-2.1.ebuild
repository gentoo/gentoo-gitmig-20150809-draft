# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanssh/scanssh-2.1.ebuild,v 1.7 2007/09/14 05:04:23 jer Exp $

inherit eutils

DESCRIPTION="network scanner that gathers info on SSH protocols and versions"
HOMEPAGE="http://monkey.org/~provos/scanssh/"
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ppc sparc x86"
IUSE=""

DEPEND="net-libs/libpcap
	dev-libs/libdnet
	>=dev-libs/libevent-0.8a"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.0-fix-warnings.diff
	touch configure
}

src_install() {
	dobin scanssh || die
	doman scanssh.1
}
