# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unpaper/unpaper-0.3.ebuild,v 1.2 2010/11/16 13:14:46 fauli Exp $

inherit toolchain-funcs

DESCRIPTION="Post-processor for scanned and photocopied book pages"
HOMEPAGE="http://unpaper.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

doecho() {
	echo "$@"
	"$@"
}

src_compile() {
	doecho $(tc-getCC) ${LDFLAGS} ${CFLAGS} src/unpaper.c -o unpaper -lm \
		|| die "unable to build unpaper"
}

src_install() {
	dobin unpaper || die
	dodoc CHANGELOG README || die
	dohtml -r doc/* || die
}
