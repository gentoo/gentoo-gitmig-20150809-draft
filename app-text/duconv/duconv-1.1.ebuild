# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/cvsroot/gentoo-x86/app-misc/screen.ebuild,v 1.2 2001/04/21
# 19:25 CST blutgens Exp $

S=${WORKDIR}/${P}
DESCRIPTION=" small util that converts from dos<->unix"
SRC_URI="http://people.freenet.de/tfaehr/${PN}.tgz"
HOMEPAGE="http://people.freenet.de/tfaehr/linux.htm"
LICENSE=""
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
