# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nut/nut-14.1.ebuild,v 1.5 2011/01/22 17:00:11 fauli Exp $

EAPI=2

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Record what you eat and analyze your nutrient levels"
HOMEPAGE="http://nut.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~amd64 ~arm ppc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-build-fixes.patch
}

src_compile() {
	append-flags '-DNUTDIR=\".nutdb\" -DFOODDIR=\"/usr/share/nut\"'
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	insinto /usr/share/nut
	doins raw.data/* || die
	dobin nut || die
	doman nut.1 || die
}
