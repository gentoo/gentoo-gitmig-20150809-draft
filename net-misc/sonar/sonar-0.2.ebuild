# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sonar/sonar-0.2.ebuild,v 1.1 2004/10/06 11:43:48 blubb Exp $

inherit eutils

IUSE=""

DESCRIPTION="An ICMP Chat"
SRC_URI="http://platon.intra-tec.de/sonar/${P}.tar.gz"
HOMEPAGE="http://platon.intra-tec.de/sonar/index.html"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.4
	>=net-libs/libpcap-0.8.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/sonar-0.2.patch
}

src_compile() {
	emake || die 'Compilation failed!'
}

src_install() {
	dobin sonar
}
