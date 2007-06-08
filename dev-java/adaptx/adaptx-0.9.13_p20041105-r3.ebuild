# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/adaptx/adaptx-0.9.13_p20041105-r3.ebuild,v 1.5 2007/06/08 15:20:30 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

MY_PN=${PV%%_p*}
MY_SNAPSHOT=${PV##*_p}
DESCRIPTION="Adaptx is an XSLT processor and XPath engine"
HOMEPAGE="http://project.exolab.org/cgi-bin/viewcvs.cgi/adaptx/?cvsroot=adaptx"
SRC_URI="mirror://gentoo/${PN}-${MY_SNAPSHOT}.gentoo.tar.bz2"
LICENSE="Exolab"
CDEPEND="=dev-java/log4j-1.2*
	=dev-java/xml-commons-external-1.3*
	>=dev-java/xerces-2.7
	dev-java/ant-core"
RDEPEND="=virtual/jre-1.4*
	${CDEPEND}"
DEPEND="=virtual/jdk-1.4*
	${CDEPEND}"
SLOT="0.9"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

S="${WORKDIR}/${PN}-${MY_SNAPSHOT}"

src_compile() {
	# tried to build sources with jikes but
	# failed all the time on different
	# plattforms (amd64, x86)
	java-pkg_filter-compiler jikes

	cd src/
	local cp="$(java-pkg_getjars xml-commons-external-1.3,xerces-2,log4j,ant-core)"
	eant -Dclasspath="${cp}" jar $(use_doc)
}

src_install() {
	java-pkg_newjar dist/${PN}_${MY_PN}.jar
	use doc && java-pkg_dojavadoc build/doc/javadoc
	use source && java-pkg_dosrc src/main/*
	cd build/classes
	dodoc CHANGELOG README || die
}
