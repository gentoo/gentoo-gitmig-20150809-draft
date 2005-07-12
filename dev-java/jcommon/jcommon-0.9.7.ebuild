# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommon/jcommon-0.9.7.ebuild,v 1.5 2005/07/12 19:44:58 axxo Exp $

inherit java-pkg

DESCRIPTION="JCommon is a collection of useful classes used by JFreeChart, JFreeReport and other projects."
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/jfreechart/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant
		dev-java/junit
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f junit/*
}

src_compile() {
	local antflags="compile javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant -f ant/build.xml ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar ${P}.jar
	dodoc README.txt licence-LGPL.txt
	use doc && java-pkg_dohtml -r javadoc
}

