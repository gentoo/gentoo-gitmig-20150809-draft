# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.5.3-r2.ebuild,v 1.2 2003/04/26 05:36:58 strider Exp $

S="${WORKDIR}/apache-ant-${PV}-1"
DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
SRC_URI="mirror://apache/ant/source/apache-${PN}-${PV}-1-src.tar.bz2"
HOMEPAGE="http://ant.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/glibc
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE="doc"

src_compile() {
	export JAVA_HOME=${JDK_HOME}
	if [ `arch` == "ppc" ] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi
	if [ -f /usr/share/junit/lib/junit.jar ] ; then
		# make sure junit tasks get built if we have junit
		export CLASSPATH=/usr/share/junit/lib/junit.jar
	fi
	./build.sh -Ddist.dir=${D}/usr/share/ant || die
}

src_install() {
	cp ${FILESDIR}/${PV}/ant ${S}/src/ant

	exeinto /usr/bin
	doexe src/ant

	dojar build/lib/*.jar build/lib/*.jar

	dodoc LICENSE LICENSE.* README WHATSNEW KEYS
	use doc && dohtml welcome.html
	use doc && dohtml -r docs/*
}
