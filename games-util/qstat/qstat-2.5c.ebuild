# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-2.5c.ebuild,v 1.1 2004/08/17 01:35:38 vapier Exp $

MY_P="${PN}${PV/.}"
DESCRIPTION="Server statics collector supporting many FPS games"
HOMEPAGE="http://www.qstat.org/"
SRC_URI="http://www.qstat.org/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc hppa amd64"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install () {
	dobin qstat || die "dobin failed"

	dosym /usr/bin/qstat /usr/bin/quakestat

	dodoc CHANGES.txt COMPILE.txt
	dohtml template/* qstatdoc.html
}
