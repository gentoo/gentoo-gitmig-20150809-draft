# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/7plus/7plus-2.25.ebuild,v 1.2 2004/03/12 09:18:39 mr_bones_ Exp $

S="${WORKDIR}/7plsrc.${PV//./}"
DESCRIPTION="An encoder for packet radio"
HOMEPAGE="http://home.t-online.de/home/dg1bbq/7plus.htm"
SRC_URI="http://home.t-online.de/home/dg1bbq/7pl${PV//./}sr.tgz"

LICENSE="7plus"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="sys-apps/sed"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:CC = gcc:CC = ${CC}:" \
		-e "s:-O2:${CFLAGS}:" linux.mak > Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin 7plus                                || die "dobin failed"
	dodoc 7pl_hist.nts 7plh_old.nts format.def || die "dodoc failed"
}
