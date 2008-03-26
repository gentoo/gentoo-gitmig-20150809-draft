# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/clockywock/clockywock-0.2.3.ebuild,v 1.4 2008/03/26 17:09:00 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="ncurses analog clock"
HOMEPAGE="http://www.soomka.com"
SRC_URI="http://www.soomka.com/${P}.tar.gz"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

src_compile() {
	$(tc-getCXX) ${CXXFLAGS} -Wall -o ${PN} ${PN}.cpp -lncurses -lpthread || die "build failed."
}

src_install() {
	dobin ${PN}
	dodoc README
}
