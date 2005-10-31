# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/wsdl4j/wsdl4j-1.5.1.ebuild,v 1.1 2005/10/31 14:31:30 axxo Exp $

inherit java-pkg

DESCRIPTION="Web Services Description Language for Java Toolkit (WSDL4J)"
HOMEPAGE="http://wsdl4j.sourceforge.net"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2 http://www.keanu.be/distfiles/${P}-gentoo.tar.bz2"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc jikes junit source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	junit? ( dev-java/junit )
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	local antflags="compile"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar build/lib/*.jar

	dohtml doc/*.html
	dodoc doc/spec/*

	use doc && java-pkg_dohtml -r build/javadocs/
	use source && java-pkg_dosrc src/*
}
