# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/hexcalc/hexcalc-1.11-r2.ebuild,v 1.1 2010/06/22 13:40:00 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="A simple hex calculator for X"
HOMEPAGE="ftp://ftp.x.org/R5contrib/"
SRC_URI="ftp://ftp.x.org/R5contrib/${PN}.tar.Z"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXaw"
DEPEND="${RDEPEND}
	x11-misc/imake
	app-text/rman"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch ${FILESDIR}/${PN}-* || die
}

src_compile() {
	xmkmf || die
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		CCLINK="$(tc-getCC)" \
		LDOPTIONS="${LDFLAGS}" \
		|| die
}

src_install() {
	dobin hexcalc || die
	mv hexcalc.man hexcalc.1
	doman hexcalc.1 || die
}
