# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jms/jms-1.1.ebuild,v 1.1 2004/10/30 18:52:14 axxo Exp $

inherit java-pkg

At="jms-${PV/./_}-fr-apidocs.zip"
DESCRIPTION="The Java Message Service (JMS) API is a messaging standard that allows application components to create, send, receive, and read messages."
HOMEPAGE="http://java.sun.com/products/jms/"
SRC_URI="${At}"
LICENSE="sun-bcla-jms"
SLOT=0
KEYWORDS="~x86 ~amd64"
IUSE="jikes doc"
RDEPEND=">=virtual/jre-1.3"
DEPEND="app-arch/unzip
		>=virtual/jdk-1.3"
RESTRICT="fetch"

S=${WORKDIR}/${PN}${PV}

pkg_nofetch() {
	einfo " "
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo " "
	einfo " 1. Visit ${HOMEPAGE} and select 'Downloads'"
	einfo " 2. Select 'Download the version 1.1 API Documentation, Jar and Source'"
	einfo " 3. Download ${At}"
	einfo " 4. Move file to ${DISTDIR}"
	einfo " "
}

src_compile() {
	mkdir build
	cd src/share
	javac_cmd="javac"
	use jikes && java_cmd="jikes -bootclasspath ${JAVA_HOME}/jre/lib/rt.jar"

	${javac_cmd} -nowarn -d ${S}/build $(find -name "*.java")
	if use doc ; then
		mkdir ${S}/api
		javadoc -d ${S}/api -quiet javax.jms
	fi

	cd ${S}
	jar cf jms.jar -C build .
}

src_install() {
	java-pkg_dojar jms.jar
	use doc && java-pkg_dohtml -r api
}

