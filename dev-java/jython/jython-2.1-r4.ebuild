# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jython/jython-2.1-r4.ebuild,v 1.2 2004/07/31 16:01:14 karltk Exp $

DESCRIPTION="An implementation of Python written in Java"
HOMEPAGE="http://www.jython.org"
MY_PV="21"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.class"
LICENSE="JPython"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="readline jikes"
# servlet

DEPEND=">=virtual/jdk-1.2
	readline? ( >=dev-java/libreadline-java-0.8.0 )
	jikes? ( >=dev-java/jikes-1.18 )
	!dev-java/jython-bin
	"
#	servlet? ( >=net-www/tomcat-5.0 )

src_unpack() {
	addwrite .hotspot
	cd ${DISTDIR}
	java ${PN}-${MY_PV} -o ${S}/ demo lib source
}

compile_set() {

	for x in $* ; do
		if [ -d $x ] ; then
			find $* -name "*.java"  | xargs ${javac} -source 1.3 -nowarn || die "Failed to compile"
		else
			${javac} -source 1.3 -nowarn $x || die "Failed to compile"
		fi
	done
}

src_compile() {

	javac=$(java-config -c)
	if use jikes ; then
		java=$(which jikes)
	fi

	# 2004-07-31: karltk
	# Hack to not clutter up the CLASSPATH env var globally
	oldCLASSPATH=${CLASSPATH}

	export CLASSPATH=${CLASSPATH}:.

	compile_set org/python/core org/python/rmi org/python/parser
	compile_set org/python/util/jython.java

	if use readline ; then
		export CLASSPATH="${CLASSPATH}:$(java-config -p libreadline-java)"
		compile_set org/python/util/ReadlineConsole.java
	fi

	# 2004-07-31: karltk
	# Need to add back in most of org/python/modules/
#	if use servlet ; then
#		CLASSPATH="${CLASSPATH}:$(java-config -p servlet)"
#		compile_set org/python/util/PyServlet.java
#	fi

	find org -name "*.class" | xargs jar cf jython-${PV}.jar

	export CLASSPATH=${oldCLASSPATH}
}

src_install() {
	dojar jython-${PV}.jar
	dodoc {README,LICENSE}.txt NEWS ACKNOWLEDGMENTS
	dohtml -A .css .jpg .gif -r Doc
	newbin ${FILESDIR}/jython jython
	newbin ${FILESDIR}/jythonc jythonc

	dodir /usr/share/jython/cachedir
	chmod a+rw ${D}/usr/share/jython/cachedir

	cp -R Lib/* ${D}/usr/share/${PN}/lib/
	mkdir ${D}/usr/share/${PN}/tools/
	cp -R Tools/* ${D}/usr/share/${PN}/tools/
}
