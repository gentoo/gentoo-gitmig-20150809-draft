# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-graph/commons-graph-0.8.1_p20040118-r1.ebuild,v 1.1 2006/07/22 22:48:22 nelchael Exp $

inherit java-pkg-2 java-ant-2 eutils
MY_PN=graph2
MY_PV=${PV%%_*}.cvs${PV##*_p}
MY_P=${MY_PN}-${MY_PV}
API_PV=${PV%%_*}
DESCRIPTION="A toolkit for managing graphs and graph based data structures"
# There doesn't seem to be a real home page, so we'll point to a viewcvs
HOMEPAGE="http://cvs.apache.org/viewcvs/jakarta-commons-sandbox/graph2/"
# this was extracted from a source rpm at jpackage
SRC_URI="mirror://gentoo/distfiles/${MY_P}.tar.gz"
COMMON_DEP="dev-java/log4j
	dev-java/commons-collections
	dev-java/xml-commons"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	test? ( dev-java/ant-tasks )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
S=${WORKDIR}/${MY_P}

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from log4j
	java-pkg_jar-from commons-collections
	java-pkg_jar-from xml-commons xml-apis.jar

}

src_compile(){
	local antflags="jar -Dnoget=true"
	use doc && antflags="${antflags} javadoc"
	eant ${antflags} || die "compile failed"
}

src_install(){
	java-pkg_newjar target/${PN}-${API_PV}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/api
}

src_test() {
	if use test; then
		local antflags="test -Dnoget=true"
		eant ${antflags} || die "test failed"
	else
		ewarn "You must include 'test' in your use flags in order to"
		ewarn "get the dependencies needed to run unit tests"
		ewarn "Skipping unit tests"
	fi
}
