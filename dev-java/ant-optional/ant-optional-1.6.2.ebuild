# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-optional/ant-optional-1.6.2.ebuild,v 1.6 2004/07/30 21:38:25 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="Apache ANT Optional Tasks Jar Files"
HOMEPAGE="http://ant.apache.org/"
SRC_URI="mirror://apache/ant/source/apache-ant-${PV}-src.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="javamail"

DEPEND="=dev-java/ant-${PV}
	>=dev-java/java-config-1.2
	>=dev-java/log4j-1.2.8
	>=dev-java/xerces-2.6.1
	>=dev-java/xalan-2.5.2
	>=dev-java/junit-3.8
	>=dev-java/bsh-1.2-r7
	>=dev-java/antlr-2.7.2
	>=dev-java/commons-beanutils-1.6.1
	>=dev-java/commons-logging-1.0.3
	>=dev-java/commons-net-1.1.0
	>=dev-java/bcel-5.1
	>=dev-java/oro-2.0.7
	>=dev-java/rhino-1.5_rc4
	>=dev-java/jdepend-2.6
	>=dev-java/jsch-0.1.12
	>=dev-java/regexp-bin-1.3
	>=dev-java/jython-bin-2.1
	javamail? ( >=dev-java/sun-javamail-bin-1.3 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/apache-ant-${PV}"

src_compile() {
	addwrite "/proc/self/maps"
	export JAVA_HOME=${JDK_HOME}
	if [ `arch` == "ppc" ] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi

	packages="ant,antlr,bcel,bsh,commons-beanutils,commons-net,commons-logging,jdepend,jsch,junit,jython,log4j,oro,regexp,rhino,xalan,xerces-2"
	use javamail && packages="${packages},sun-javamail-bin,sun-jaf-bin"

	libs=$(java-config -p ${packages})
	./build.sh -Ddist.dir=${D}/usr/share/ant -lib ${libs} || die "build failed"
}

src_install() {
	local jars="antlr apache-bcel junit vaj apache-bsf apache-log4j weblogic \
		apache-resolver apache-oro netrexx xalan1 nodeps apache-regexp \
		commons-logging javamail starteam xslp commons-net jdepend stylebook \
		icontract jmf swing jai jsch trax"

	dodir /usr/share/ant/lib
	for jar in ${jars}; do
		java-pkg_dojar build/lib/ant-${jar}.jar
		dosym /usr/share/ant-optional/lib/ant-${jar}.jar /usr/share/ant/lib/
	done
}
