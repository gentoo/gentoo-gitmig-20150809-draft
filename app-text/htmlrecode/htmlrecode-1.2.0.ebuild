# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlrecode/htmlrecode-1.2.0.ebuild,v 1.5 2007/07/12 04:37:47 mr_bones_ Exp $

DESCRIPTION="Recodes HTML file using a new character set"
HOMEPAGE="http://bisqwit.iki.fi/source/htmlrecode.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="virtual/libc"

IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

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
	dobin htmlrecode
	dodoc README.html
}
