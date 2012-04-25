# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/yacas/yacas-1.2.2.ebuild,v 1.8 2012/04/25 17:08:36 jlec Exp $

inherit eutils java-pkg-opt-2

DESCRIPTION="Powerful general purpose computer algebra system"
HOMEPAGE="http://yacas.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/backups/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

IUSE="doc java server"

DEPEND="java? ( >=virtual/jdk-1.6 )"
RDEPEND="java? ( >=virtual/jre-1.6 )"

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-makefixes.patch
}

src_compile() {
	econf \
		$(use_enable doc html-doc) \
		$(use_enable server) \
		--with-html-dir="/usr/share/doc/${PF}/html"
	emake || die "emake failed"
	if use java; then
		cd JavaYacas || die
		# -j1 because of file generation dependence
		emake -j1 -f makefile.yacas || die "emake java interface failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO || die
	if use java; then
		cd JavaYacas || die
		java-pkg_dojar yacas.jar
		java-pkg_dolauncher jyacas --main net.sf.yacas.YacasConsole
		insinto /usr/share/${PN}
		doins hints.txt yacasconsole.html || die "doins java resources failed"
	fi
}
