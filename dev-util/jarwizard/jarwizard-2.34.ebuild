# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jarwizard/jarwizard-2.34.ebuild,v 1.4 2004/11/03 11:47:56 axxo Exp $

inherit java-pkg

DESCRIPTION="Takes the hassle out of creating executable JAR files for your Java programs"
SRC_URI="mirror://sourceforge/jarwizard/${PN}_${PV/./}_src.zip"
HOMEPAGE="http://www.geocities.com/chir_geo/jarc/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~alpha ~ppc"
IUSE="jikes"
DEPEND=">=virtual/jdk-1.3
		app-arch/unzip
		jikes? ( >=dev-java/jikes-1.16 )"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${PN}"

src_compile() {
	if use jikes ; then
		jikes -O -source 1.3 *.java
	else
		javac -g:none -source 1.3 *.java
	fi
}

src_install() {
	echo "Manifest-Version: 1.0" > manifest
	echo "Main-Class: JarWizard" >> manifest
	jar cfm ${PN}.jar manifest *.class *.properties org gui
	java-pkg_dojar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /usr/share/${PN}" >> ${PN}
	echo "java -cp lib/${PN}.jar JarWizard" >> ${PN}
	dobin ${PN}
}
