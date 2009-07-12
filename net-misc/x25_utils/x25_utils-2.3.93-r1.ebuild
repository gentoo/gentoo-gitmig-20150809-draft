# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x25_utils/x25_utils-2.3.93-r1.ebuild,v 1.1 2009/07/12 12:41:35 mrness Exp $

EAPI="2"

inherit eutils linux-info

DESCRIPTION="Utilities to configure X.25 networks"
HOMEPAGE="http://www.baty.hanse.de/"
SRC_URI="http://www.baty.hanse.de/linux-x25/utils/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

pkg_setup() {
	CONFIG_CHECK="~X25"
	linux-info_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	emake -j1 O="${CFLAGS} -Wno-trigraphs" || die "emake failed"
}

src_install() {
	newbin telnet/telnet x25telnet
	newsbin telnetd/telnetd x25.telnetd
	dosbin route/x25route trace/x25trace
	newman telnet/telnet.1 x25telnet.1
	newman telnetd/telnetd.8 x25.telnetd.8
	doman route/x25route.8 trace/x25trace.8
	newdoc trace/Changes Changes.x25trace
	newdoc telnet/README README.telnet
	dodoc Changes README
}
