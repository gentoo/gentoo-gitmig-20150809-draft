# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/csvfix/csvfix-1.10a.ebuild,v 1.1 2011/08/07 18:53:36 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs versionator

MY_PV="$(delete_all_version_separators)"
MY_P="${PN}_src_${MY_PV}"
DESCRIPTION="A stream editor for manipulating CSV files"
HOMEPAGE="http://code.google.com/p/csvfix/"
SRC_URI="http://csvfix.googlecode.com/files/${MY_P}.zip
	doc? ( http://csvfix.googlecode.com/files/${PN}_man_html_${MY_PV/a/}.zip )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}-build

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.00c-make.patch \
		"${FILESDIR}"/${P}-tests.patch \
		"${FILESDIR}"/${P}-escape-exec.patch

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
	use doc && dohtml -r "${WORKDIR}"/CSVfix-HTML/*
}
