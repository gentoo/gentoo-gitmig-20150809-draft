# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jitac/jitac-0.2.0-r1.ebuild,v 1.1 2004/09/21 18:05:24 axxo Exp $

inherit java-pkg

DESCRIPTION="An image to ASCII converter written in Java"
HOMEPAGE="http://www.roqe.org/jitac/"
SRC_URI="http://www.roqe.org/jitac/${P}.src.jar"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="virtual/jdk
		dev-java/jimi"
RDEPEND="virtual/jre
		dev-java/jimi"

S=${WORKDIR}

src_unpack() {
	cd ${S}
	jar -xvf ${DISTDIR}/${A}
}

src_compile() {
	cd ${S}
	find . -name "*.java" | xargs javac -target 1.2 -classpath $(java-config -p jimi):. || die "failed to compile"
	find . -name "*.class" -or -name "*.bdf" -or -name "*.properties" | xargs jar -cf ${PN}.jar || die "failes to ceate jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "\${JAVA_HOME}/bin/java -classpath \${CLASSPATH}:\$(java-config -p jimi,jitac) org.roqe.jitac.Jitac \$*" >> ${PN}
	dobin ${PN}

	dodoc org/roqe/jitac/README
	use doc && dohtml -r org/roqe/jitac/docs/*
}

