# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pure-sfv/pure-sfv-0.3.ebuild,v 1.9 2005/05/04 19:13:16 dholm Exp $

DESCRIPTION="utility to test and create .sfv files and create .par files"
HOMEPAGE="http://pure-sfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/pure-sfv/${PN}_${PV}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	sed -i 's:-O2 -g::' ${S}/Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin pure-sfv || die
	dodoc ReadMe.txt
}
