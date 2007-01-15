# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.2_beta1.ebuild,v 1.1 2007/01/15 00:55:21 nichoj Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library, It is used to extend JAVA classes and implements interfaces at runtime."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-1.1"
SLOT="2.2"
KEYWORDS="~x86 ~amd64"
COMMON_DEP="=dev-java/asm-2.2*"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )
	>=dev-java/ant-core-1.5
	dev-java/jarjar
	${COMMON_DEP}"
IUSE="doc source"

S=${WORKDIR}

src_unpack() {
	jar xf ${DISTDIR}/${A} || die "failed to unpack"

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from asm-2.2 asm.jar
	java-pkg_jar-from asm-2.2 asm-util.jar
	java-pkg_jar-from asm-2.2 asm-commons.jar
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from --build-only jarjar-1
}

src_install() {
	java-pkg_newjar dist/${PN}-${PV}.jar ${PN}.jar
	java-pkg_newjar dist/${PN}-nodep-${PV}.jar ${PN}-nodep.jar

	dodoc NOTICE README
	use doc && java-pkg_dohtml -r docs/*
}
