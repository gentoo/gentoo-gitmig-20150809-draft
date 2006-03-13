# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/bff/bff-1.0.3.1.ebuild,v 1.3 2006/03/13 16:49:03 blubb Exp $

DESCRIPTION="a brainfuck interpreter"
HOMEPAGE="http://swapped.cc/bf/"
SRC_URI="http://swapped.cc/bf/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	gcc -o bff bff.c
}

src_install() {
	dobin bff
	into /usr

	dodoc README
}
