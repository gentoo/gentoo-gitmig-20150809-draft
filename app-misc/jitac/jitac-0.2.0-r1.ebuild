# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jitac/jitac-0.2.0-r1.ebuild,v 1.12 2007/07/12 03:35:11 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="An image to ASCII converter written in Java"
HOMEPAGE="http://www.roqe.org/jitac/"
SRC_URI="http://www.roqe.org/jitac/${P}.src.jar"
LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3
		dev-java/sun-jimi"
RDEPEND=">=virtual/jre-1.3
		dev-java/sun-jimi"

S=${WORKDIR}

src_unpack() {
	cd ${S}
	jar -xvf ${DISTDIR}/${A} || die "failed too unpack"
}

src_compile() {
	cd ${S}
	find . -name "*.java" | xargs javac -target 1.2 -classpath $(java-pkg_getjars sun-jimi):. || die "failed to compile"
	find . -name "*.class" -or -name "*.bdf" -or -name "*.properties" | xargs jar -cf ${PN}.jar || die "failes to ceate jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "\${JAVA_HOME}/bin/java -classpath \${CLASSPATH}:\$(java-config -p sun-jimi,jitac) org.roqe.jitac.Jitac \$*" >> ${PN}
	dobin ${PN}

	dodoc org/roqe/jitac/README
	use doc && java-pkg_dohtml -r org/roqe/jitac/docs/*
}
