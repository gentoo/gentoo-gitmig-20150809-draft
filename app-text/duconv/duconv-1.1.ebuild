# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/duconv/duconv-1.1.ebuild,v 1.16 2005/06/05 12:01:09 hansmi Exp $

DESCRIPTION="A small util that converts from dos<->unix"
SRC_URI="http://people.freenet.de/tfaehr/${PN}.tgz"
HOMEPAGE="http://people.freenet.de/tfaehr/linux.htm"
LICENSE="as-is"
KEYWORDS="~mips ppc sparc x86"
SLOT="0"

IUSE=""
DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/home/torsten/gcc/duconv ${S}
	cd ${S}
	sed -i -e 's,-m486,,' Makefile || die "Makefile fix failed"
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
