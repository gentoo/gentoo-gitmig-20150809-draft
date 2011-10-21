# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nut/nut-17.2.ebuild,v 1.1 2011/10/21 23:11:08 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Record what you eat and analyze your nutrient levels"
HOMEPAGE="http://nut.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
IUSE="X"

RDEPEND="X? ( x11-libs/fltk:1 )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-16.12-makefile.patch
}

src_compile() {
	emake CC=$(tc-getCC) FOODDIR=\\\"/usr/share/nut\\\"
	if use X ; then
		cd fltk
		emake CXX=$(tc-getCXX) FOODDIR=\\\"/usr/share/nut\\\"
	fi
}

src_install() {
	insinto /usr/share/nut
	doins raw.data/*
	dobin nut
	doman nut.1
	if use X ; then
		dobin fltk/Nut
		doicon nut.xpm
		make_desktop_entry Nut nut nut Education
	fi
}
