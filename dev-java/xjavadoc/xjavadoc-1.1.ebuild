# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xjavadoc/xjavadoc-1.1.ebuild,v 1.5 2005/07/13 12:09:14 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="XDoclet is an extended Javadoc Doclet engine."
HOMEPAGE="http://xdoclet.sf.net/"
SRC_URI="mirror://sourceforge/xdoclet/${P}-src.zip
	mirror://sourceforge/xdoclet/${P}-supplement.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="jikes source"

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-collections
	dev-java/javacc"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	app-arch/unzip
	>=dev-java/ant-core-1.6
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-buildfile.patch

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from commons-collections
	java-pkg_jar-from javacc
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use source && java-pkg_dosrc ${S}/src/*
}
