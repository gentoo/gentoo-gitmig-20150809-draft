# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/clockywock/clockywock-0.2.3d.ebuild,v 1.1 2010/03/26 20:36:34 ssuominen Exp $

inherit toolchain-funcs

MY_P=${P/d/D}

DESCRIPTION="ncurses based analog clock"
HOMEPAGE="http://www.soomka.com"
SRC_URI="http://www.soomka.com/${MY_P}.tar.gz"

LICENSE="BZIP2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/${MY_P}

src_compile() {
	$(tc-getCXX) ${LDFLAGS} ${CXXFLAGS} -Wall -o ${PN} ${PN}.cpp -lncurses -lpthread || die
}

src_install() {
	dobin ${PN} || die
	dodoc README
}
