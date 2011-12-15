# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwmon/bwmon-1.3.ebuild,v 1.20 2011/12/15 16:16:19 jer Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Simple ncurses bandwidth monitor"
HOMEPAGE="http://bwmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="amd64 hppa ~ppc sparc x86"
IUSE=""

doecho() {
	echo "$@"
	"$@"
}

src_compile() {
	append-flags -I"${S}"/include -D__THREADS

	doecho $(tc-getCC) -o ${PN} \
		${CFLAGS} ${LDFLAGS} \
		src/${PN}.c -lncurses -lpthread \
		|| die "build failed"
}

src_install () {
	dobin ${PN} || die
	dodoc README || die
}
