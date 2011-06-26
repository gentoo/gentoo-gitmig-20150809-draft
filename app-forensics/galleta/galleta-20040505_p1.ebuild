# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/galleta/galleta-20040505_p1.ebuild,v 1.7 2011/06/26 07:37:09 radhermit Exp $

inherit toolchain-funcs

MY_P=${PN}_${PV/_p/_}
DESCRIPTION="IE Cookie Parser"
HOMEPAGE="http://sourceforge.net/projects/odessa/"
SRC_URI="mirror://sourceforge/odessa/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_compile() {
	cd src
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o galleta galleta.c -lm -lc || die "failed to compile"
}

src_install() {
	dodoc Readme.txt
	dobin src/galleta
}
