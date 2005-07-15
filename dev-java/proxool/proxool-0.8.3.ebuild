# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/proxool/proxool-0.8.3.ebuild,v 1.6 2005/07/15 17:53:24 axxo Exp $

inherit java-pkg

DESCRIPTION="Proxool is a Java connection pool."
HOMEPAGE="http://proxool.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.3
	dev-java/cglib"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

src_compile() {
	local antflags="build-jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc README.txt
	use doc && java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/java/*
}
