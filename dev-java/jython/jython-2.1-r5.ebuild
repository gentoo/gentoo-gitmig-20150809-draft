# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jython/jython-2.1-r5.ebuild,v 1.7 2004/09/17 02:05:42 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="An implementation of Python written in Java"
HOMEPAGE="http://www.jython.org"
MY_PV="21"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.class"
LICENSE="JPython"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE="readline jikes"
# servlet

DEPEND=">=virtual/jdk-1.2
	readline? ( >=dev-java/libreadline-java-0.8.0 )
	jikes? ( >=dev-java/jikes-1.18 )"
#	servlet? ( >=net-www/tomcat-5.0 )

src_unpack() {
	addwrite .hotspot
	cp ${DISTDIR}/${A} ${WORKDIR}
	cd ${WORKDIR}
	`java-config -J` -classpath . ${PN}-${MY_PV} -o ${S}/ demo lib source || die "unpack failed"

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

	find org -name "*.java" ${exclude} | xargs ${javac} -classpath ${cp} -nowarn || die "Failed to compile"

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
	cp registry ${D}/usr/share/${PN}/
}

pkg_postinst() {
	if use readline; then
		einfo "To use readline you need to add the following to your registery"
		einfo
		einfo "python.console=org.python.util.ReadlineConsole"
		einfo "python.console.readlinelib=GnuReadline"
		einfo
		einfo "The global registry can be found in /usr/share/${PN}/registry"
		einfo "User registry in \$HOME/.jython"
		einfo "See http://www.jython.org/docs/registry.html for more information"
	fi
}
