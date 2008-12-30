# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tprint/tprint-1.1.0.ebuild,v 1.4 2008/12/30 20:31:38 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="Transparent Print Utility for terminals"
HOMEPAGE="http://sourceforge.net/projects/tprint/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:-g -O2 -Wall:${CFLAGS}:g" \
		-e "s:cc:$(tc-getCC):" \
		Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /etc/tprint
	insinto /etc/tprint
	doins tprint.conf
	exeinto /usr/bin
	doexe tprint || die "doexe failed"

	dodoc INSTALL README
}
