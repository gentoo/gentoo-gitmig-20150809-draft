# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/duconv/duconv-1.1.ebuild,v 1.6 2002/09/05 16:30:22 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small util that converts from dos<->unix"
SRC_URI="http://people.freenet.de/tfaehr/${PN}.tgz"
HOMEPAGE="http://people.freenet.de/tfaehr/linux.htm"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"
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
