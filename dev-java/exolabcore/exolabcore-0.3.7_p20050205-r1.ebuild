# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/exolabcore/exolabcore-0.3.7_p20050205-r1.ebuild,v 1.1 2006/12/21 19:15:38 betelgeuse Exp $

inherit eutils java-pkg-2 java-ant-2

MY_DATE="${PV##*_p}"
MY_PV="${PV%%_p*}"
MY_P="${PN}-${MY_DATE}"

DESCRIPTION="Exolab Build Tools"
HOMEPAGE="http://openjms.cvs.sourceforge.net/openjms/exolabcore/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="Exolab"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

COMMON_DEP="
	dev-java/cdegroot-db
	dev-java/commons-cli
	dev-java/commons-logging
	dev-java/exolabtools
	=dev-java/jakarta-oro-2.0*
	=dev-java/xerces-1.3*"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}
	dev-java/ant-core
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}/src"
	epatch "${FILESDIR}/${P}-buildfile.patch"

	cd "${S}/lib"
	rm -f *.jar
	java-pkg_jar-from cdegroot-db-1
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from commons-logging
	java-pkg_jar-from exolabtools
	java-pkg_jar-from jakarta-oro-2.0 jakarta-oro.jar oro.jar
	java-pkg_jar-from xerces-1.3
}

src_compile() {
	cd "${S}/src"
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar dist/${PN}-${MY_PV}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc build/doc/javadoc
	use source && java-pkg_dosrc src/main/*
}
