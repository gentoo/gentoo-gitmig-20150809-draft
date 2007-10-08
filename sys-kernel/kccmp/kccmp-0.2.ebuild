# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/kccmp/kccmp-0.2.ebuild,v 1.1 2007/10/08 12:00:34 mpagano Exp $

inherit eutils qt3 qt4

DESCRIPTION="A simple tool for comparing two linux kernel .config files"
HOMEPAGE="http://stoopidsimple.com/kccmp/"
SRC_URI="http://stoopidsimple.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="qt3 qt4"
DEPEND="qt3? (  $(qt_min_version 3.3.8-r4) )
	qt4? ( $(qt4_min_version 4.3.1-r1) >=dev-libs/boost-1.33.1-r1 )"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	use qt4 && epatch "${FILESDIR}"/${P}-qt4.patch
}

src_compile() {
	# Generates top-level Makefile
	if use qt4; then
		eqmake4
	else
		eqmake3
	fi

	emake || die "emake failed"
}

src_install() {
	dobin kccmp || die "installing binary failed"
	dodoc README
}
