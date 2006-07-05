# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.1.3.ebuild,v 1.1 2006/07/05 05:19:25 nichoj Exp $

inherit eutils java-pkg-2 java-ant-2

MY_PV=${PV/1./1_}
DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library, It is used to extend JAVA classes and implements interfaces at runtime."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${MY_PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-1.1"
SLOT="2.1"
KEYWORDS="~x86 ~amd64"
COMMON_DEP="=dev-java/asm-1.5*
	=dev-java/aspectwerkz-2*"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )
	>=dev-java/ant-core-1.5
	dev-java/jarjar
	${COMMON_DEP}"
IUSE="doc"

S=${WORKDIR}

ant_src_unpack() {
	jar xf ${DISTDIR}/${A} || die "failed to unpack"

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from asm-1.5
	java-pkg_jar-from aspectwerkz-2
	java-pkg_jar-from jarjar-1
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_newjar dist/${PN}-${MY_PV}.jar ${PN}.jar
	java-pkg_newjar dist/${PN}-nodep-${MY_PV}.jar ${PN}-nodep.jar

	dodoc NOTICE README
	use doc && java-pkg_dohtml -r docs/*
}
