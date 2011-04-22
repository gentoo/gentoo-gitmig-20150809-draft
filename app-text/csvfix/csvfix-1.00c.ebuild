# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/csvfix/csvfix-1.00c.ebuild,v 1.1 2011/04/22 05:05:34 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs versionator

MY_P="${PN}_src_$(delete_all_version_separators)"
DESCRIPTION="A stream editor for manipulating CSV files"
HOMEPAGE="http://code.google.com/p/csvfix/"
SRC_URI="http://csvfix.googlecode.com/files/${MY_P}.zip
	doc? ( http://csvfix.googlecode.com/files/${PN}_man_html_100.zip )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# Currently fails the exec test
RESTRICT="test"

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}-build

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch \
		"${FILESDIR}"/${P}-tests.patch

	edos2unix $(find csvfix/test -type f)
}

src_compile() {
	emake CC="$(tc-getCXX)" AR="$(tc-getAR)" lin
}

src_test() {
	cd ${PN}/test
	chmod +x run1 runall
	./runall || die "tests failed"
}

src_install() {
	dobin csvfix/bin/csvfix
	use doc && dohtml "${WORKDIR}"/HTML/*
}
