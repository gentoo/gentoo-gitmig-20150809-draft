# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.1.2.ebuild,v 1.3 2005/07/31 15:28:05 st_lim Exp $

inherit eutils java-pkg

MY_PV=${PV/1./1_}
DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library, It is used to extend JAVA classes and implements interfaces at runtime."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${MY_PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-1.1"
SLOT="2.1"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=virtual/jre-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	=dev-java/asm-1.5*
	=dev-java/aspectwerkz-2*
	dev-java/jarjar"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-core-1.5"
IUSE="doc jikes"

S=${WORKDIR}

src_unpack() {
	jar xf ${DISTDIR}/${A} || die "failed to unpack"

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from asm-1.5
	java-pkg_jar-from aspectwerkz-2
	java-pkg_jar-from jarjar-1
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "builed to build"
}

src_install() {
	java-pkg_newjar ${S}/dist/${PN}-${MY_PV}.jar ${PN}.jar
	java-pkg_newjar ${S}/dist/${PN}-nodep-${MY_PV}.jar ${PN}-nodep.jar

	dodoc NOTICE README
	use doc && java-pkg_dohtml -r docs/*
}
