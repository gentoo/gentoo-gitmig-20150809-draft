# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/wsdl4j/wsdl4j-1.4.ebuild,v 1.11 2005/07/19 18:31:29 axxo Exp $

inherit java-pkg

DESCRIPTION="Web Services Description Language for Java Toolkit (WSDL4J)"
HOMEPAGE="http://www-124.ibm.com/developerworks/projects/wsdl4j"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes junit source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	junit? ( dev-java/junit )
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${PN}"

src_compile() {
	local antflags="compile"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar build/lib/*.jar

	dodoc doc/fab/JSR110_final_approval_ballot.pdf doc/fab/final-questions.txt
	use doc && java-pkg_dohtml -r build/javadocs/*
	use source && java-pkg_dosrc src/*
}
