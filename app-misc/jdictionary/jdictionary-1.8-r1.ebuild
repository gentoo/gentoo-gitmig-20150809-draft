# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jdictionary/jdictionary-1.8-r1.ebuild,v 1.6 2005/08/16 19:23:35 blubb Exp $

inherit java-pkg

DESCRIPTION="A online Java-based dictionary"
HOMEPAGE="http://jdictionary.sourceforge.net/"
SRC_URI="mirror://sourceforge/jdictionary/jdictionary-${PV/./_}.zip"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND=">=virtual/jre-1.3"
DEPEND=">=virtual/jdk-1.3
		app-arch/unzip"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir compiled

	jar xf ${PN}.jar || die "failed to unpack jar"
	cp -r resources compiled
}

src_compile(){
	javac -classpath . $(find . -name \*.java) -d compiled || die "failed to build"
	jar cf ${PN}.jar -C compiled .
}

src_install() {
	java-pkg_dojar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "java -classpath \$(java-config -p ${PN}) info.jdictionary.JDictionary '\$*'" >> ${PN}

	dobin ${PN}
}
