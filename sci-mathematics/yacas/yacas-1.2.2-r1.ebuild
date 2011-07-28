# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/yacas/yacas-1.2.2-r1.ebuild,v 1.2 2011/07/28 20:18:54 bicatali Exp $

EAPI="4"

inherit eutils java-pkg-opt-2 autotools

DESCRIPTION="General purpose computer algebra system"
HOMEPAGE="http://yacas.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/backups/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="doc java server"

DEPEND="java? ( >=virtual/jdk-1.6 )"
RDEPEND="java? ( >=virtual/jre-1.6 )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-gcc46.patch \
		"${FILESDIR}"/${P}-makefixes.patch \
		"${FILESDIR}"/${P}-tests.patch
	# needs to rebuild because tests include file modify Makefile.am
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable doc html-doc) \
		$(use_enable server) \
		--with-html-dir="/usr/share/doc/${PF}/html"
}

src_compile() {
	default
	if use java; then
		cd JavaYacas || die
		# -j1 because of file generation dependence
		emake -j1 -f makefile.yacas
	fi
}

src_install() {
	default
	if use java; then
		cd JavaYacas || die
		java-pkg_dojar yacas.jar
		java-pkg_dolauncher jyacas --main net.sf.yacas.YacasConsole
		insinto /usr/share/${PN}
		doins hints.txt yacasconsole.html
	fi
}
