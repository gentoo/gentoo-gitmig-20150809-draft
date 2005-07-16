# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/charva/charva-1.0.1.ebuild,v 1.10 2005/07/16 14:40:37 axxo Exp $

inherit java-pkg

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
KEYWORDS="x86 ppc amd64"

src_unpack() {
	unpack ${A}
	rm ${S}/c/src/libTerminal.so
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
	dolib.so c/src/*.so
	use doc && java-pkg_dohtml -r java/doc
	dodoc README
}
