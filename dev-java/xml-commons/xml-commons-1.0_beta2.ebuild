# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml-commons/xml-commons-1.0_beta2.ebuild,v 1.8 2005/03/23 14:51:36 gustavoz Exp $

inherit eutils java-pkg

DESCRIPTION="Jakarta project for for XML bindings for java"
HOMEPAGE="http://xml.apache.org/commons/"
SRC_URI="mirror://apache/xml/commons/xml-commons-1.0.b2.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc64 ~sparc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/xml-commons-1.0.b2

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-jdk15.patch
}

src_compile() {
	local antflags="jar"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"

	cd ${S}/java
	ant -f resolver.xml ${antflags} || die "XML-Resolver Compile failed"
	ant -f which.xml ${antflags} || die "XML-Which Compile failed"
}

src_install() {
	java-pkg_dojar java/build/which.jar
	java-pkg_dojar java/build/resolver.jar
	java-pkg_dojar java/external/build/xml-apis.jar

	dodoc README.html
	use doc && java-pkg_dohtml -r java/build/docs/*
}
