# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-lang/commons-lang-2.0-r1.ebuild,v 1.17 2006/10/05 15:27:43 gustavoz Exp $

inherit java-pkg

DESCRIPTION="Jakarta components to manipulate core java classes"
HOMEPAGE="http://jakarta.apache.org/commons/lang/"
SRC_URI="mirror://apache/jakarta/commons/lang/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc amd64 ppc64"
IUSE="doc jikes source"

S="${WORKDIR}/${P}-src"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	if use doc; then
		dodoc RELEASE-NOTES.txt
		java-pkg_dohtml DEVELOPERS-GUIDE.html PROPOSAL.html STATUS.html
		java-pkg_dohtml -r dist/docs/
	fi
	use source && java-pkg_dosrc src/java/*
}
