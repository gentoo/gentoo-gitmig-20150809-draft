# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rcsi/rcsi-0.5.ebuild,v 1.3 2009/10/12 08:25:14 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="A program to give information about RCS files"
HOMEPAGE="http://www.colinbrough.pwp.blueyonder.co.uk/rcsi.README.html"
SRC_URI="http://www.colinbrough.pwp.blueyonder.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="sys-apps/sed"
RDEPEND=">=app-text/rcs-5.7-r2"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	CC="$(tc-getCC)"
	sed -e "s^gcc -Wall -O2 -Xlinker -s^${CC} -Wall ${CFLAGS}^g" -i "${S}"/Makefile
}

src_compile() {
	emake -j1 rcsi || die
}

src_install() {
	dobin rcsi || die
	doman rcsi.1
	dodoc README
	dohtml README.html example{1,2}.png
}
