# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rcsi/rcsi-0.5.ebuild,v 1.1 2005/02/13 03:46:18 robbat2 Exp $

inherit eutils toolchain-funcs
DESCRIPTION="A program to give information about RCS files"
URI_BASE="http://www.colinbrough.pwp.blueyonder.co.uk"
HOMEPAGE="${URI_BASE}/rcsi.README.html"
SRC_URI="${URI_BASE}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-apps/sed"
RDEPEND=">=app-text/rcs-5.7-r2"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	# Make the upstream Makefile honour $CC and optimisations.
	CC="$(tc-getCC)"
	sed -e "s^gcc -Wall -O2 -Xlinker -s^${CC} -Wall ${CFLAGS}^g" -i ${S}/Makefile
}

src_compile() {
	emake -j1 rcsi
}

src_install() {
	dobin rcsi
	doman rcsi.1
	dodoc README
	dohtml README.html example{1,2}.png
}
