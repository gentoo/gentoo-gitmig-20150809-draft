# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.5.3-r4.ebuild,v 1.1 2003/05/26 11:05:17 absinthe Exp $

inherit java-pkg

S="${WORKDIR}/apache-ant-${PV}-1"
DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
SRC_URI="mirror://apache/ant/source/apache-${PN}-${PV}-1-src.tar.bz2"
HOMEPAGE="http://ant.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
DEPEND="virtual/glibc"
RDEPEND=">=virtual/jdk-1.3"
IUSE="doc"

src_compile() {
	export JAVA_HOME=${JDK_HOME}
	if [ `arch` == "ppc" ] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi

	# Make sure junit tasks get built if we have junit
	if [ -f "/usr/share/junit/lib/junit.jar" ] ; then
		export CLASSPATH="/usr/share/junit/lib/junit.jar"
		export DEP_APPEND="junit"
		if [ -f "/usr/share/xalan/lib/xalan.jar" ] ; then
			export CLASSPATH="${CLASSPATH}:/usr/share/xalan/lib/xalan.jar"
			export DEP_APPEND="${DEP_APPEND} xalan"
		fi
	fi
	
	# Add Xerces in if we have it
	if [ -f "/usr/share/xerces/lib/xercesImpl.jar" ] ; then
		export CLASSPATH="${CLASSPATH}:/usr/share/xerces/lib/xercesImpl.jar:/usr/share/xerces/lib/xml-apis.jar"
		export DEP_APPEND="${DEP_APPEND} xerces"
	fi

	# Add oro in if we have it
	if [ -f "/usr/share/oro/lib/oro.jar" ] ; then
		export CLASSPATH="${CLASSPATH}:/usr/share/oro/lib/oro.jar"
		export DEP_APPEND="${DEP_APPEND} oro"
	fi
	
	# Add beanutils if we have it
	if [ -f "/usr/share/commons-beanutils/lib/commons-beanutils.jar" ] ; then
		export CLASSPATH="${CLASSPATH}:/usr/share/commons-beanutils/lib/commons-beanutils.jar"
		export DEP_APPEND="${DEP_APPEND} commons-beanutils"
	fi

	# add antlr if we have it
	if [ -f "/usr/share/antlr/lib/antlr.jar" ] ; then
		export CLASSPATH="${CLASSPATH}:/usr/share/antlr/lib/antlr.jar"
		export DEP_APPEND="${DEP_APPEND} antlr"
	fi
	
	./build.sh -Ddist.dir=${D}/usr/share/ant || die
}

src_install() {
	cp ${FILESDIR}/${PV}/ant ${S}/src/ant
	
	exeinto /usr/bin
	doexe src/ant
	for each in antRun runant.pl runant.py complete-ant-cmd.pl ; do
		dobin ${S}/src/script/${each}
	done

	java-pkg_dojar build/lib/*.jar
	
	dodoc LICENSE LICENSE.* README WHATSNEW KEYS
	use doc && dohtml welcome.html
	use doc && dohtml -r docs/*
}
