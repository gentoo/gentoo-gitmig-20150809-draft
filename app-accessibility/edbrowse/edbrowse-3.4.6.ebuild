# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/edbrowse/edbrowse-3.4.6.ebuild,v 1.2 2011/03/16 04:11:22 williamh Exp $

EAPI="4"
inherit eutils

DESCRIPTION="editor, browser, and mail client using the /bin/ed interface"
HOMEPAGE="http://edbrowse.sourceforge.net/"
SRC_URI="http://www.eklhad.net/${PN}/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="linguas_fr odbc"
COMMON_DEPEND="<dev-lang/spidermonkey-1.9
	>=sys-libs/readline-6.0
	>=net-misc/curl-7.17.0
	>=dev-libs/libpcre-7.8
	>=dev-libs/openssl-0.9.8j
	odbc? ( dev-db/unixODBC )"
DEPEND="${COMMON_DEPEND}
	app-arch/unzip"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-makefile.patch
	epatch "${FILESDIR}"/${P}-fix-off-by-one.patch
}

src_compile() {
	emake prefix=/usr
	if use odbc; then
		# Top-level makefile doesn't have this target.
		cd src
		emake prefix=/usr edbrowseodbc
		cd ..
	fi
}

src_install() {
	cd src
	emake prefix=/usr DESTDIR="${D}" install
	if use odbc; then
		dobin edbrowseodbc
	fi
	cd ..
	dodoc CHANGES README todo
	cd doc
	dobin setup.ebrc
	dohtml usersguide.html philosophy.html
	dodoc sample.ebrc
	if use linguas_fr; then
		dohtml usersguide_fr.html philosophy_fr.html
		dodoc sample_fr.ebrc
	fi
}
