# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/bff/bff-1.0.3.1.ebuild,v 1.5 2006/09/09 09:05:26 blubb Exp $

inherit toolchain-funcs

DESCRIPTION="a brainfuck interpreter"
HOMEPAGE="http://swapped.cc/bf/"
SRC_URI="http://swapped.cc/bf/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	$(tc-getCC) ${CFLAGS} -o bff bff.c || die "compile failed"
}

src_install() {
	dobin bff
	into /usr

	dodoc README
}
