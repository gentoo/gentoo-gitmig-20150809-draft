# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-optional/ant-optional-1.6.0-r2.ebuild,v 1.4 2004/01/22 01:26:46 strider Exp $

inherit java-pkg

IUSE="doc antlr bcel bsh javamail jdepend jsch junit jython log4j oro regexp rhino xalan xerces"

S="${WORKDIR}/apache-ant-${PV}"
DESCRIPTION="Apache ANT Optional Tasks Jar Files"
SRC_URI="mirror://apache/ant/source/apache-ant-${PV}-src.tar.bz2"
HOMEPAGE="http://ant.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
DEPEND="=dev-java/ant-1.6.0-r2
	>=dev-java/java-config-1.2
	log4j? ( >=dev-java/log4j-1.2.8 )
	xerces? ( >=dev-java/xerces-2.6 )
	xalan? ( >=dev-java/xalan-2.5.2 )
	junit? ( >=dev-java/junit-3.8 )
	bsh? ( >=dev-java/bsh-1.2-r7 )
	antlr? ( >=dev-java/antlr-2.7.2 )
	>=dev-java/commons-beanutils-1.6.1
	>=dev-java/commons-logging-1.0.3
	>=dev-java/commons-net-1.0.0
	bcel? ( >=dev-java/bcel-5.1 )
	oro? ( >=dev-java/oro-2.0.7 )
	rhino? ( >=dev-java/rhino-1.4 )
	jdepend? ( >=dev-java/jdepend-2.6 )
	jsch? ( >=dev-java/jsch-0.1.12 )
	regexp? ( >=dev-java/regexp-1.3 )
	jython? ( >=dev-java/jython-2.1 )
	javamail? ( >=dev-java/javamail-1.3 )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch build.sh to die with non-zero exit code in case of errors.
	# This patch may be useful for all ant versions.
#	epatch ${FILESDIR}/build.sh-exit-fix.patch.gz
}

src_compile() {

	addwrite "/proc/self/maps"
	export JAVA_HOME=${JDK_HOME}
	if [ `arch` == "ppc" ] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi

	for i in "antlr,bcel,bsh,commons-beanutils,commons-logging,javamail,jaf,jdepend,jsch,junit,jython,log4j,oro,regexp,rhino,xalan,xerces"; do
		export CLASSPATH="${CLASSPATH}`java-config --classpath=${i}`"
	done
	./build.sh -Ddist.dir=${D}/usr/share/ant || die
}

src_install() {
	dodir /usr/share/ant/lib
	java-pkg_dojar build/lib/ant-antlr.jar
	dosym /usr/share/ant-optional/lib/ant-antlr.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-jakarta-bcel.jar
	dosym /usr/share/ant-optional/lib/ant-jakarta-bcel.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-junit.jar
	dosym /usr/share/ant-optional/lib/ant-junit.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-vaj.jar
	dosym /usr/share/ant-optional/lib/ant-vaj.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-apache-bsf.jar
	dosym /usr/share/ant-optional/lib/ant-apache-bsf.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-jakarta-log4j.jar
	dosym /usr/share/ant-optional/lib/ant-jakarta-log4j.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-weblogic.jar
	dosym /usr/share/ant-optional/lib/ant-weblogic.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-apache-resolver.jar
	dosym /usr/share/ant-optional/lib/ant-apache-resolver.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-jakarta-oro.jar
	dosym /usr/share/ant-optional/lib/ant-jakarta-oro.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-netrexx.jar
	dosym /usr/share/ant-optional/lib/ant-netrexx.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-xalan1.jar
	dosym /usr/share/ant-optional/lib/ant-xalan1.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-nodeps.jar
	dosym /usr/share/ant-optional/lib/ant-nodeps.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-jakarta-regexp.jar
	dosym /usr/share/ant-optional/lib/ant-jakarta-regexp.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-xalan2.jar
	dosym /usr/share/ant-optional/lib/ant-xalan2.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-commons-logging.jar
	dosym /usr/share/ant-optional/lib/ant-commons-logging.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-javamail.jar
	dosym /usr/share/ant-optional/lib/ant-javamail.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-starteam.jar
	dosym /usr/share/ant-optional/lib/ant-starteam.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-xslp.jar
	dosym /usr/share/ant-optional/lib/ant-xslp.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-commons-net.jar
	dosym /usr/share/ant-optional/lib/ant-commons-net.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-jdepend.jar
	dosym /usr/share/ant-optional/lib/ant-jdepend.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-stylebook.jar
	dosym /usr/share/ant-optional/lib/ant-stylebook.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-icontract.jar
	dosym /usr/share/ant-optional/lib/ant-icontract.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-jmf.jar
	dosym /usr/share/ant-optional/lib/ant-jmf.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-swing.jar
	dosym /usr/share/ant-optional/lib/ant-swing.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-jai.jar
	dosym /usr/share/ant-optional/lib/ant-jai.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-jsch.jar
	dosym /usr/share/ant-optional/lib/ant-jsch.jar /usr/share/ant/lib/
	java-pkg_dojar build/lib/ant-trax.jar
	dosym /usr/share/ant-optional/lib/ant-trax.jar /usr/share/ant/lib/
}
