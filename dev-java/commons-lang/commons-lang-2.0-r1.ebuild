# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-lang/commons-lang-2.0-r1.ebuild,v 1.4 2004/03/23 03:22:37 zx Exp $

inherit java-pkg

DESCRIPTION="Jakarta components to manipulate core java classes"
HOMEPAGE="http://jakarta.apache.org/commons/lang.html"
SRC_URI="mirror://apache/jakarta/commons/lang/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
RESTRICT="nomirror"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="doc jikes junit"

S="${WORKDIR}/${PN}-${PV}-src"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	mv dist/${P}.jar dist/${PN}.jar
	java-pkg_dojar dist/*.jar
	dodoc RELEASE-NOTES.txt
	dohtml DEVELOPERS-GUIDE.html PROPOSAL.html STATUS.html
	use doc && dohtml -r dist/docs/
}
