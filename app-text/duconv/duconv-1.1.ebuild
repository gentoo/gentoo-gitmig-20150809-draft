# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/duconv/duconv-1.1.ebuild,v 1.10 2004/02/22 20:02:31 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small util that converts from dos<->unix"
SRC_URI="http://people.freenet.de/tfaehr/${PN}.tgz"
HOMEPAGE="http://people.freenet.de/tfaehr/linux.htm"
LICENSE="as-is"
KEYWORDS="x86 sparc"
SLOT="0"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/home/torsten/gcc/duconv ${S}
	rm -R ${WORKDIR}/home
}

src_compile() {
	make all || die
}

src_install () {
	exeinto /usr/bin
	doexe ${PN}
	doman duconv.1
}
