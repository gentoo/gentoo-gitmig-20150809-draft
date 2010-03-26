# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/clockywock/clockywock-0.2.3.ebuild,v 1.6 2010/03/26 20:37:42 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="ncurses analog clock"
HOMEPAGE="http://www.soomka.com"
SRC_URI="http://www.soomka.com/${P}.tar.gz"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	$(tc-getCXX) ${LDFLAGS} ${CXXFLAGS} -Wall -o ${PN} ${PN}.cpp -lncurses -lpthread || die
}

src_install() {
	dobin ${PN} || die
	dodoc README
}
