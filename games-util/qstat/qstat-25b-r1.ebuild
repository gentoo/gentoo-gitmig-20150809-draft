# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-25b-r1.ebuild,v 1.1 2003/09/10 18:53:23 vapier Exp $

S=${WORKDIR}/${PN}${PV}
DESCRIPTION="Server statics collector supporting many FPS games"
SRC_URI="http://www.qstat.org/${PN}${PV}.tar.gz"
HOMEPAGE="http://www.qstat.org"

KEYWORDS="x86"
LICENSE="Artistic"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${PN}${PV}.tar.gz
	cd ${S}
	patch -p1 < ${FILESDIR}/qstat-25b.gcc3-fix
}

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
