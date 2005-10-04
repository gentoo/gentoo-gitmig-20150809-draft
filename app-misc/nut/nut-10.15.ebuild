# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nut/nut-10.15.ebuild,v 1.3 2005/10/04 13:39:26 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="record what you eat and analyze your nutrient levels"
HOMEPAGE="http://www.lafn.org/~av832/"
SRC_URI="http://www.lafn.org/~av832/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
DEPEND=""

src_compile() {
	append-flags '-DNUTDIR=\".nutdb\" -DFOODDIR=\"/usr/share/nut\"'
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodir /usr/share/nut
	insinto /usr/share/nut
	doins raw.data/*
	dobin nut
	doman nut.1
}
