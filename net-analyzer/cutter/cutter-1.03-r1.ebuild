# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cutter/cutter-1.03-r1.ebuild,v 1.2 2007/03/20 13:35:42 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="TCP/IP Connection cutting on Linux Firewalls and Routers"
SRC_URI="http://www.lowth.com/cutter/software/${P}.tgz"
HOMEPAGE="http://www.lowth.com/cutter"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~ppc x86"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-debian.patch
}

src_compile() {
	echo "$(tc-getCC) ${CFLAGS} cutter.c -o cutter"
	"$(tc-getCC)" ${CFLAGS} cutter.c -o cutter
}

src_install() {
	dosbin cutter
	dodoc README
	doman debian/cutter.8
}
