# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-tasks/ant-tasks-1.6.2-r6.ebuild,v 1.1 2005/03/27 21:21:26 luckyduck Exp $

inherit java-pkg eutils

DESCRIPTION="Apache ANT Optional Tasks Jar Files"
HOMEPAGE="http://ant.apache.org/"
SRC_URI="mirror://apache/ant/source/apache-ant-${PV}-src.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~ppc64"
IUSE="javamail noantlr nobcel nobeanutils nobsh nocommonsnet nocommonslogging nojdepend nojsch nojython nolog4j nooro noregexp norhino noxalan noxerces"

DEPEND="=dev-java/ant-core-${PV}*
	!dev-java/ant-optional
	>=dev-java/java-config-1.2
	>=dev-java/junit-3.8
	!nolog4j? ( >=dev-java/log4j-1.2.8 )
	!noxerces? ( >=dev-java/xerces-2.6.2-r1 )
	!noxalan? ( >=dev-java/xalan-2.5.2 )
	!nobsh? ( >=dev-java/bsh-1.2-r7 )
	!noantlr? ( >=dev-java/antlr-2.7.2 )
	!nobeanutils? ( >=dev-java/commons-beanutils-1.6.1 )
	!nocommonslogging? ( >=dev-java/commons-logging-1.0.3 )
	!nocommonsnet? ( >=dev-java/commons-net-1.1.0 )
	!nobcel? ( >=dev-java/bcel-5.1 )
	!nooro? ( >=dev-java/oro-2.0.7 )
	!norhino? ( =dev-java/rhino-1.5* )
	!nojdepend? ( >=dev-java/jdepend-2.6 )
	!nojsch? ( >=dev-java/jsch-0.1.12 )
	!noregexp? ( =dev-java/jakarta-regexp-1.3* )
	!nojython? ( >=dev-java/jython-2.1-r5 )
	javamail? ( >=dev-java/sun-javamail-bin-1.3 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/apache-ant-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# also see #77365
	epatch ${FILESDIR}/${PV}-scp.patch
}

src_compile() {
	addwrite "/proc/self/maps"
	export JAVA_HOME=${JDK_HOME}
	if [ `arch` == "ppc" ] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi

	local p="ant-core,junit"
	use noantlr || p="${p},antlr"
	use nobcel || p="${p},bcel"
	use nobeanutils || p="${p},commons-beanutils"
	use nobsh || p="${p},bsh"
	use nocommonslogging || p="${p},commons-logging"
	use nocommonsnet || p="${p},commons-net"
	use nojdepend || p="${p},jdepend"
	use nojsch || p="${p},jsch"
	use nojython || p="${p},jython"
	use nolog4j || p="${p},log4j"
	use nooro || p="${p},oro"
	use noregexp || p="${p},jakarta-regexp-1.3"
	use norhino || p="${p},rhino-1.5"
	use noxalan || p="${p},xalan"
	use noxerces || p="${p},xerces-2"

	use javamail && p="${p},sun-javamail-bin,sun-jaf-bin"

	libs=$(java-config -p ${p})
	CLASSPATH="." ./build.sh -Ddist.dir=${D}/usr/share/ant-core -lib ${libs} || die "build failed"
}

src_install() {

	local jars="junit vaj weblogic apache-resolver netrexx  nodeps \
		starteam xslp stylebook icontract jmf swing jai trax"

	use noantlr || jars="${jars} antlr"
	use nobcel || jars="${jars} apache-bcel"
	#use nobsf || jars="${jars} apache-bsf"
	use nocommonslogging || jars="${jars} commons-logging"
	use nocommonsnet || jars="${jars} commons-net"
	use nojdepend || jars="${jars} jdepend"
	use nojsch || jars="${jars} jsch"
	use nolog4j || jars="${jars} apache-log4j"
	use nooro || jars="${jars} apache-oro"
	use noregexp || jars="${jars} apache-regexp"
	use noxalan || jars="${jars} xalan1"
	use javamail && jars="${jars} javamail"

	dodir /usr/share/ant-core/lib
	for jar in ${jars}; do
		java-pkg_dojar build/lib/ant-${jar}.jar
		dosym /usr/share/${PN}/lib/ant-${jar}.jar /usr/share/ant-core/lib/
	done
}

pkg_postinst() {
	local noset=false
	for x in ${IUSE} ; do
		if [ "${x:0:2}" == "no" ] ; then
			use ${x} && noset=true
		fi
	done
	if [ ${noset} == "true" ]; then
		ewarn "You have disabled some of the ant tasks. Be advised that this may"
		ewarn "break building some of the Java packages!!"
		ewarn ""
		ewarn "We can only offer very limited support in cases where dev-java/ant-tasks"
		ewarn "has been build with essential features disabled."
	fi
}
