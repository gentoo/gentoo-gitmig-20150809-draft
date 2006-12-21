# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/exolabtools/exolabtools-1.0_p20050205-r1.ebuild,v 1.1 2006/12/21 19:07:51 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

MY_P=${P/-1.0_p/-}

DESCRIPTION="Exolab Build Tools"
HOMEPAGE="http://openjms.cvs.sourceforge.net/openjms/tools/src/main/org/exolab/tools/ant/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="Exolab"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	=dev-java/jakarta-oro-2.0*
	=dev-java/xerces-1.3*"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}/"

src_unpack() {
	unpack "${A}"

	cd "${S}/src/etc"
	mv JARS JARS.upstream
	echo "project.jar.oro=jakarta-oro.jar" > JARS
	echo "project.jar.ant=ant.jar" >> JARS

	cd "${S}/lib"
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_jar-from ant-core
}

src_compile() {
	cd src
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar dist/${PN}-1.0.jar ${PN}.jar

	dodoc src/etc/CHANGELOG src/etc/VERSION

	use doc && java-pkg_dojavadoc build/doc
	use source && java-pkg_dosrc src/main/*
}
