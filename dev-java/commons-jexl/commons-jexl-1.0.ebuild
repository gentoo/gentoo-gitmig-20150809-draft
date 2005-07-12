# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-jexl/commons-jexl-1.0.ebuild,v 1.3 2005/07/12 12:07:58 axxo Exp $

inherit java-pkg eutils
DESCRIPTION="Expression language engine, can be embedded in applications and frameworks."
HOMEPAGE="http://jakarta.apache.org/commons/jexl"
SRC_URI="mirror://apache/java-repository/${PN}/distributions/${P}-src.tar.gz"
RDEPEND=">=virtual/jre-1.4
	dev-java/commons-logging"
DEPEND="${RDEPEND}
	jikes? ( >=dev-java/jikes-1.21 )
	junit? ( dev-java/ant >=dev-java/junit-3.8 >=virtual/jdk-1.4 )
	!junit? ( dev-java/ant-core >=virtual/jdk-1.3 )"

LICENSE="Apache-2.0"
SLOT="1.0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes junit source"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	mkdir -p target/lib && cd target/lib
	use junit && java-pkg_jar-from junit junit.jar
	java-pkg_jar-from commons-logging
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_newjar target/${P}*.jar ${PN}.jar

	if use doc; then
		dodoc RELEASE-NOTES.txt
		java-pkg_dohtml PROPOSAL.html STATUS.html usersguide.html
		java-pkg_dohtml -r dist/docs/
	fi
	use source && java-pkg_dosrc ${S}/src/java/*
}
