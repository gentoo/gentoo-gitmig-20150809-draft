# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml-commons/xml-commons-1.0_beta2.ebuild,v 1.3 2005/01/15 18:23:32 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Jakarta project for for XML bindings for java"
HOMEPAGE="http://xml.apache.org/commons/"
SRC_URI="mirror://apache/xml/commons/xml-commons-1.0.b2.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/xml-commons-1.0.b2

src_compile() {
	local antflags="jars"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_dojar java/build/which.jar
	java-pkg_dojar java/build/resolver.jar
	java-pkg_dojar java/external/build/xml-apis.jar

	dodoc README.html
	use doc && java-pkg_dohtml -r java/build/docs/*
}
