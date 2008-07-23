# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlrecode/htmlrecode-1.3.0.ebuild,v 1.1 2008/07/23 15:55:28 coldwind Exp $

inherit eutils

DESCRIPTION="Recodes HTML file using a new character set"
HOMEPAGE="http://bisqwit.iki.fi/source/htmlrecode.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-misc-fixes.patch

	sed -i \
		-e "s:^\\(ARGHLINK.*-L.*\\):#\\1:" \
		-e "s:^#\\(ARGHLINK=.*a\\)$:\\1:" \
		Makefile

	touch .depend argh/.depend
}

src_compile() {
	emake -C argh libargh.a || die
	emake htmlrecode || die
}

src_install() {
	dobin htmlrecode || die
	dodoc README.html
}
