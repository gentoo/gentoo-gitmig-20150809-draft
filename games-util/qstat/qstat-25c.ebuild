# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-25c.ebuild,v 1.4 2004/04/18 06:15:11 mr_bones_ Exp $

S="${WORKDIR}/${PN}${PV}"
DESCRIPTION="Server statics collector supporting many FPS games"
HOMEPAGE="http://www.qstat.org/"
SRC_URI="http://www.qstat.org/${PN}${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc hppa amd64"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install () {
	dobin qstat || die "dobin failed"

	dosym /usr/bin/qstat /usr/bin/quakestat

	dodoc CHANGES.txt COMPILE.txt
	dohtml template/* qstatdoc.html
}
