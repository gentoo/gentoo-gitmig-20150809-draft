# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/wsdl4j/wsdl4j-1.4.ebuild,v 1.7 2004/11/14 17:53:12 axxo Exp $

inherit java-pkg

DESCRIPTION="Web Services Description Language for Java Toolkit (WSDL4J)"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.gz"
HOMEPAGE="http://www-124.ibm.com/developerworks/projects/wsdl4j"
KEYWORDS="~x86 ~amd64"
LICENSE="CPL-1.0"
SLOT="0"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	junit? ( dev-java/junit )
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"
IUSE="doc jikes"

S="${WORKDIR}/${PN}"

src_compile() {
	antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "failed to build"
}

src_install() {
	dodoc doc/fab/JSR110_final_approval_ballot.pdf doc/fab/final-questions.txt
	dodoc doc/fab/license.txt doc/fab/terms.txt
	use doc && java-pkg_dohtml -r build/javadocs/*
	java-pkg_dojar build/lib/*.jar
}
