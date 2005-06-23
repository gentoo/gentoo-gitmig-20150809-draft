# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/pcalc/pcalc-1.0.0-r1.ebuild,v 1.1 2005/06/23 22:44:11 vapier Exp $

inherit eutils

DESCRIPTION="the programmers calculator"
HOMEPAGE="http://ibiblio.org/pub/Linux/apps/math/calc/pcalc.lsm"
SRC_URI="http://ibiblio.org/pub/Linux/apps/math/calc/pcalc-000.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/flex
	sys-devel/bison"
RDEPEND=""

S=${WORKDIR}/${PN}-000

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f pcalc
	epatch "${FILESDIR}"/${P}-static-vars.patch
	epatch "${FILESDIR}"/${P}-error-handler.patch
	epatch "${FILESDIR}"/${P}-tmpfile.patch
	epatch "${FILESDIR}"/${P}-input-overflow-check.patch
	epatch "${FILESDIR}"/${P}-operator-updates.patch
	epatch "${FILESDIR}"/${P}-usage.patch
	epatch "${FILESDIR}"/${P}-string-overflow-checks.patch
	epatch "${FILESDIR}"/${P}-duplicated-case.patch
}

src_test() {
	make test || die "make test failed :("
}

src_install() {
	dobin pcalc || die "dobin pcalc"
	dodoc EXAMPLE README
}
