# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/apache-ant.eclass,v 1.1 2003/10/18 22:07:32 strider Exp $

inherit base
ECLASS=apache-ant
INHERITED="$INHERITED $ECLASS"
IUSE="$IUSE"

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://ant.apache.org/"
LICENSE="Apache-1.1 BSD IBM NPL-1.1 JPython ANTLR"

# Depends needed for building ant
DEPEND="$DEPEND
	>=virtual/jdk-1.3"
RDEPEND="$RDEPEND >=virtual/jdk-1.3"
PDEPEND="$PDEPEND"
SLOT="$SLOT"

apache-ant_classpath() {
	if [ `use junit` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/junit.jar"
	fi
	if [ `use oro` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/oro.jar"
	fi
	if [ `use regexp` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/regexp.jar"
	fi
	if [ `use bsf` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/bsf.jar"
	fi
	if [ `use antlr` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/antlr.jar"
	fi
	if [ `use bcel` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/bcel.jar"
	fi
	if [ `use bsh` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/bsh.jar"
	fi
	if [ `use jdepend` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/jdepend.jar"
	fi
	if [ `use js` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/js.jar"
	fi
	if [ `use jython` ]; then
		CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/jython.jar"
	fi
	
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xercesImpl.jar"
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xercesSamples.jar"
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xml-apis.jar"
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xmlParserAPIs.jar"
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xalan.jar"
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xsltcapplet.jar"
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xsltcbrazil.jar"
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xsltcejb.jar"
	CLASSPATH="${CLASSPATH}:${WORKDIR}/ant-support-files/xsltcservlet.jar"
}

apache-ant_compile() {
	cd ${S}
	export JAVA_HOME=${JDK_HOME}
	if [ `use ppc` ] ; then
		# We're compiling on PPC then we need this.
		export THREADS_FLAG="green"
	fi
	./build.sh -Ddist.dir=${D}/usr/share/ant || die "Compiling Problem"
}
