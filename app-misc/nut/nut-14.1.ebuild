# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nut/nut-14.1.ebuild,v 1.1 2008/11/22 00:10:44 coldwind Exp $

EAPI=2

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Record what you eat and analyze your nutrient levels"
HOMEPAGE="http://nut.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~alpha ~amd64 ~ppc ~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-build-fixes.patch
}

src_compile() {
	append-flags '-DNUTDIR=\".nutdb\" -DFOODDIR=\"/usr/share/nut\"'
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodir /usr/share/nut
	insinto /usr/share/nut
	doins raw.data/*
	dobin nut
	doman nut.1
}
