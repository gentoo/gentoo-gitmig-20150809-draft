# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-25c.ebuild,v 1.3 2004/01/25 11:17:49 vapier Exp $

S=${WORKDIR}/${PN}${PV}
DESCRIPTION="Server statics collector supporting many FPS games"
SRC_URI="http://www.qstat.org/${PN}${PV}.tar.gz"
HOMEPAGE="http://www.qstat.org/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc hppa amd64"

DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin qstat

	dosym /usr/bin/qstat /usr/bin/quakestat

	dodoc CHANGES.txt COMPILE.txt
	dohtml template/*
	dohtml qstatdoc.html
}
