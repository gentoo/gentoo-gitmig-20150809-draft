# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/nfbtrans/nfbtrans-7.70.ebuild,v 1.3 2004/06/03 04:08:42 williamh Exp $

inherit eutils

DESCRIPTION="The braille translator from the National Federation of the Blind"
HOMEPAGE="http://www.nfb.org/nfbtrans.htm"
SRC_URI="http://www.nfb.org/braille/nfbtrans/nfbtr770.zip"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=app-arch/unzip-5.50-r2"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo-fix.patch
	mv MAKEFILE Makefile
	mv SPANISH.ZIP spanish.zip
	make lowercase || die
}

src_compile() {
	make LIBS= CFLAGS="${CFLAGS} -DLINUX" all || die
}

src_install() {
	dobin nfbtrans
	dodoc *fmt readme.txt makedoc
	insinto /etc/nfbtrans
	doins *cnf *tab *dic spell.dat *zip
}
