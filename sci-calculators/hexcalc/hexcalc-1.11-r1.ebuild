# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/hexcalc/hexcalc-1.11-r1.ebuild,v 1.1 2006/07/25 18:07:34 josejx Exp $

inherit eutils

DESCRIPTION="A simple hex calculator for X"
HOMEPAGE="ftp://ftp.x.org/R5contrib/"
SRC_URI="ftp://ftp.x.org/R5contrib/${PN}.tar.Z"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( x11-libs/libXaw virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( x11-misc/imake app-text/rman ) virtual/x11 )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-order.diff
}

src_compile() {
	xmkmf || die
	make || die
}

src_install() {

	dobin hexcalc
	mv hexcalc.man hexcalc.1
	doman hexcalc.1
}
