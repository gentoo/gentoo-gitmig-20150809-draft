# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jdictionary/jdictionary-1.8-r1.ebuild,v 1.2 2004/11/03 11:56:00 axxo Exp $

inherit java-pkg

DESCRIPTION="A online Java-based dictionary"
HOMEPAGE="http://jdictionary.sourceforge.net/"
SRC_URI="mirror://sourceforge/jdictionary/jdictionary-${PV/./_}.zip"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="app-arch/unzip"
S=${WORKDIR}/${PN}

src_compile(){
	mkdir compiled

	javac -classpath . `find . -name \*.java` -d compiled

	# resources are not included in sources :-/
	jar xf ${PN}.jar
	cp -r resources compiled

	jar cf ${PN}.jar -C compiled .
}

src_install() {
	java-pkg_dojar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "\$(java-config -J) -classpath \$(java-config -p ${PN}) info.jdictionary.JDictionary '\$*'" >> ${PN}

	dobin ${PN}
}
