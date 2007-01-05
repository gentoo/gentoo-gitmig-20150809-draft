# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jython/jython-2.1-r7.ebuild,v 1.4 2007/01/05 23:34:00 caster Exp $

inherit java-pkg-2

DESCRIPTION="An implementation of Python written in Java"
HOMEPAGE="http://www.jython.org"
MY_PV="21"
#SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.class"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="JPython"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~ppc64"
IUSE="readline source doc"
# servlet

RDEPEND=">=virtual/jre-1.2
	readline? ( >=dev-java/libreadline-java-0.8.0 )"
#	servlet? ( >=net-www/tomcat-5.0 )
DEPEND=">=virtual/jdk-1.2
	source? ( app-arch/zip )
	${RDEPEND}"

src_compile() {
	local cp="."
	local exclude=""

	if use readline ; then
		cp=${cp}:$(java-pkg_getjars libreadline-java)
	else
		exclude="${exclude} ! -name ReadlineConsole.java"
	fi

	#if use servlet; then
	#	cp=${cp}:$(java-pkg_getjars servlet)
	#else
		exclude="${exclude} ! -name PyServlet.java"
	#fi

	ejavac -classpath ${cp} -nowarn $(find org -name "*.java" ${exclude})

	find org -name "*.class" | xargs jar cf ${PN}.jar
}

src_install() {
	java-pkg_dojar ${PN}.jar

	dodoc README.txt NEWS ACKNOWLEDGMENTS
	use doc && java-pkg_dohtml -A .css .jpg .gif -r Doc/*

	java-pkg_dolauncher jythonc \
						--main "org.python.util.jython" \
						--java_args '-Dpython.home=/usr/share/jython' \
						--pkg_args '/usr/share/jython/tools/jythonc/jythonc.py'

	java-pkg_dolauncher jython \
						--main 'org.python.util.jython' \
						--java_args '-Dpython.home="/usr/share/jython"'

	dodir /usr/share/jython/cachedir
	chmod a+rw ${D}/usr/share/jython/cachedir

	rm Demo/jreload/example.jar
	insinto /usr/share/${PN}
	doins -r Lib Demo registry

	insinto /usr/share/${PN}/tools
	doins -r Tools/*

	use source && java-pkg_dosrc com org
}

pkg_postinst() {
	if use readline; then
		elog "To use readline you need to add the following to your registery"
		elog
		elog "python.console=org.python.util.ReadlineConsole"
		elog "python.console.readlinelib=GnuReadline"
		elog
		elog "The global registry can be found in /usr/share/${PN}/registry"
		elog "User registry in \$HOME/.jython"
		elog "See http://www.jython.org/docs/registry.html for more information"
	fi
}
