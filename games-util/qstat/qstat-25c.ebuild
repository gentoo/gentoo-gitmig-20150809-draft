# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-25c.ebuild,v 1.2 2004/01/06 02:43:40 avenj Exp $

S=${WORKDIR}/${PN}${PV}
DESCRIPTION="Server statics collector supporting many FPS games"
SRC_URI="http://www.qstat.org/${PN}${PV}.tar.gz"
HOMEPAGE="http://www.qstat.org/"

KEYWORDS="x86 ppc ~amd64"
LICENSE="Artistic"
SLOT="0"

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
