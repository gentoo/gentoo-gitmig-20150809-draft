# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/hexcalc/hexcalc-1.11.ebuild,v 1.1 2003/06/26 20:36:14 avenj Exp $

DESCRIPTION="A simple hex calculator for X"
HOMEPAGE="ftp://ftp.x.org/R5contrib/"
SRC_URI="ftp://ftp.x.org/R5contrib/${PN}.tar.Z"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11"

S=${WORKDIR}/${PN}


src_compile() {
	xmkmf || die
	make || die
}

src_install() {

	dobin hexcalc
	mv hexcalc.man hexcalc.1
	doman hexcalc.1
}
