# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/adaptx/adaptx-0.9.13_p20041105-r2.ebuild,v 1.7 2007/04/26 11:55:32 opfer Exp $

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

MY_PN=${PV%%_p*}
MY_SNAPSHOT=${PV##*_p}
DESCRIPTION="Adaptx is an XSLT processor and XPath engine"
HOMEPAGE="http://project.exolab.org/cgi-bin/viewcvs.cgi/adaptx/?cvsroot=adaptx"
SRC_URI="mirror://gentoo/${PN}-${MY_SNAPSHOT}.gentoo.tar.bz2"
LICENSE="Exolab"
CDEPEND="=dev-java/rhino-1.5*
	=dev-java/log4j-1.2*
	dev-java/gnu-jaxp
	dev-java/xml-commons
	>=dev-java/xerces-2.7"
RDEPEND="=virtual/jre-1.4*
	dev-java/ant-core
	${CDEPEND}"
DEPEND="=virtual/jdk-1.4*
	${CDEPEND}"
SLOT="0.9"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

S=${WORKDIR}/adaptx-20041105

src_compile() {
	cd src/
	# tried to build sources with jikes but
	# failed all the time on different
	# plattforms (amd64, x86)
	local cp="$(java-pkg_getjars xerces-2,xml-commons,rhino-1.5,gnu-jaxp,log4j,ant-core)"
	eant -Dclasspath="${cp}" jar $(use_doc)
}

src_install() {
	java-pkg_newjar dist/${PN}_${MY_PN}.jar ${PN}.jar
	use doc && java-pkg_dojavadoc build/doc/javadoc
	use source && java-pkg_dosrc src/main/*
	cd build/classes
	dodoc CHANGELOG README
}
