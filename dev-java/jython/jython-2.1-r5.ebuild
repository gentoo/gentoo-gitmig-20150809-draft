# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jython/jython-2.1-r5.ebuild,v 1.2 2004/09/03 15:46:38 axxo Exp $

inherit java-pkg

DESCRIPTION="An implementation of Python written in Java"
HOMEPAGE="http://www.jython.org"
MY_PV="21"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.class"
LICENSE="JPython"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="readline jikes"
# servlet

DEPEND=">=virtual/jdk-1.2
	readline? ( >=dev-java/libreadline-java-0.8.0 )
	jikes? ( >=dev-java/jikes-1.18 )
	!dev-java/jython-bin"
#	servlet? ( >=net-www/tomcat-5.0 )

src_unpack() {
	addwrite .hotspot
	cd ${DISTDIR}
	java ${PN}-${MY_PV} -o ${S}/ demo lib source
}

src_compile() {
	javac=$(java-config -c)
	if use jikes ; then
		java=$(which jikes)
	fi

	local cp=".:${CLASSPATH}"
	local exclude=""

	if use readline ; then
		cp=${cp}:$(java-config -p libreadline-java)
	else
		exclude="${exclude} ! -name ReadlineConsole.java"
	fi

	#if use servlet; then
	#	cp=${cp}:$(java-config -p servlet)
	#else
		exclude="${exclude} ! -name PyServlet.java"
	#fi

	find org -name "*.java" ${exclude} | xargs ${javac} -classpath ${cp} -source 1.3 -nowarn || die "Failed to compile"

	find org -name "*.class" | xargs jar cf jython-${PV}.jar
}

src_install() {
	java-pkg_dojar jython-${PV}.jar || die "install failed"

	dodoc {README,LICENSE}.txt NEWS ACKNOWLEDGMENTS
	dohtml -A .css .jpg .gif -r Doc
	newbin ${FILESDIR}/jython jython
	newbin ${FILESDIR}/jythonc jythonc

	dodir /usr/share/jython/cachedir
	chmod a+rw ${D}/usr/share/jython/cachedir

	cp -R Lib ${D}/usr/share/${PN}/
	cp -R Demo ${D}/usr/share/${PN}/

	dodir /usr/share/${PN}/tools/
	cp -R Tools/* ${D}/usr/share/${PN}/tools/
}
