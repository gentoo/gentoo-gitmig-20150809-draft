# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/charva/charva-1.0.1-r1.ebuild,v 1.1 2006/07/06 03:39:54 nichoj Exp $

inherit java-pkg-2

DESCRIPTION="A Java Windowing Toolkit for Text Terminals"
SRC_URI="http://www.pitman.co.za/projects/charva/download/${P}.tar.gz"
HOMEPAGE="http://www.pitman.co.za/projects/charva/"
IUSE="doc"
RDEPEND=">=virtual/jre-1.3
		sys-libs/ncurses"
DEPEND=">=virtual/jdk-1.3
		${RDEPEND}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

src_unpack() {
	unpack ${A}
	rm ${S}/c/src/libTerminal.so
	sed -e "s,javac,javac $(java-pkg_javac-args)," -i ${S}/java/src/Makefile || die
}

src_compile() {
	cd c/src
	make -f Makefile.linux || die

	cd ${S}/java/src
	make || die
}

src_install() {
	cd ${S}
	java-pkg_dojar java/lib/${PN}.jar
	use doc && java-pkg_dohtml -r java/doc
	dodoc README

	cd c/src/
	java-pkg_doso *.so
}
