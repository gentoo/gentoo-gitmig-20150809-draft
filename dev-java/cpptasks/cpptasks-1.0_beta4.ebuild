# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cpptasks/cpptasks-1.0_beta4.ebuild,v 1.5 2006/12/20 23:30:36 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

MY_P="${PN}-${PV/_beta/b}"
DESCRIPTION="Ant-tasks to compile various source languages and produce executables, shared libraries and static libraries"
HOMEPAGE="http://ant-contrib.sourceforge.net/"
SRC_URI="mirror://sourceforge/ant-contrib/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc source examples"

RDEPEND=">=virtual/jre-1.4
	 >=dev-java/ant-core-1.5
	 >=dev-java/xerces-2.7"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}"

src_unpack() {

	unpack ${A}
	cd ${S}
	rm -f *.jar
	java-ant_rewrite-classpath "${S}/build.xml"

}

src_compile() {

	local antflags="jars"
	use doc && antflags="${antflags} javadocs -Dbuild.javadocs=build/api"
	eant \
		-Dgentoo.classpath=$(java-pkg_getjars ant-core,xerces-2) \
		${antflags}

}

src_install() {

	java-pkg_dojar build/lib/${PN}.jar

	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/

	dodoc NOTICE
	use doc && java-pkg_dohtml -r build/api
	use examples && dodoc samples/*
	use source && java-pkg_dosrc src/net

}
