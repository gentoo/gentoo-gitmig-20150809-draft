# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/csvfix/csvfix-1.20.ebuild,v 1.1 2011/12/14 03:56:06 radhermit Exp $

EAPI="4"

inherit eutils toolchain-funcs versionator

MY_PV="$(delete_all_version_separators)"
DESCRIPTION="A stream editor for manipulating CSV files"
HOMEPAGE="http://code.google.com/p/csvfix/"
SRC_URI="http://csvfix.googlecode.com/files/${PN}_src_${MY_PV}.zip
	doc? ( http://csvfix.googlecode.com/files/${PN}_man_html_${MY_PV}.zip )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}-build"

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch
	epatch "${FILESDIR}"/${PN}-1.10a-tests.patch

	edos2unix $(find csvfix/tests -type f)
}

src_compile() {
	emake CC="$(tc-getCXX)" AR="$(tc-getAR)" lin
}

src_test() {
	cd ${PN}/tests
	chmod +x run1 runtests
	./runtests || die "tests failed"
}

src_install() {
	dobin csvfix/bin/csvfix
	use doc && dohtml -r "${WORKDIR}"/${PN}${MY_PV}-html/*
}
