# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/hexcalc/hexcalc-1.11.ebuild,v 1.7 2007/07/22 07:29:44 dberkholz Exp $

DESCRIPTION="A simple hex calculator for X"
HOMEPAGE="ftp://ftp.x.org/R5contrib/"
SRC_URI="ftp://ftp.x.org/R5contrib/${PN}.tar.Z"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libXaw"
DEPEND="${RDEPEND}
	x11-misc/imake
	app-text/rman"

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
