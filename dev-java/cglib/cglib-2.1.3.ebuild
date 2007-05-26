# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.1.3.ebuild,v 1.7 2007/05/26 17:29:08 nelchael Exp $

JAVA_PKG_IUSE="doc source"
WANT_SPLIT_ANT="true"

inherit eutils java-pkg-2 java-ant-2

MY_PV=${PV/1./1_}
DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${MY_PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-1.1"
SLOT="2.1"
KEYWORDS="~amd64 ~ppc ~x86"
COMMON_DEP="=dev-java/asm-1.5*
	=dev-java/aspectwerkz-2*
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	dev-java/jarjar
	${COMMON_DEP}"
IUSE="doc source"

S=${WORKDIR}

src_unpack() {
	jar xf ${DISTDIR}/${A} || die "failed to unpack"

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from asm-1.5
	java-pkg_jar-from aspectwerkz-2
	java-pkg_jar-from ant-core ant.jar
}

src_compile() {
	ANT_TASKS="jarjar-1" eant jar $(use_doc)
}

src_install() {
	java-pkg_newjar dist/${PN}-${MY_PV}.jar ${PN}.jar
	java-pkg_newjar dist/${PN}-nodep-${MY_PV}.jar ${PN}-nodep.jar

	dodoc NOTICE README || die
	use doc && java-pkg_dohtml -r docs/*
}
