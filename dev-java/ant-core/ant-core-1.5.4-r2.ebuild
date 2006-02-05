# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-core/ant-core-1.5.4-r2.ebuild,v 1.7 2006/02/05 11:05:30 blubb Exp $

inherit java-pkg eutils

MY_PN=${PN/-core}
DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
HOMEPAGE="http://ant.apache.org/"
SRC_URI="http://archive.apache.org/dist/ant/source/apache-${MY_PN}-${PV}-src.zip"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc source"

DEPEND="virtual/libc
	!<dev-java/ant-1.5.4-r2
	>=virtual/jdk-1.3
	source? ( app-arch/zip )
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.3"

S="${WORKDIR}/apache-ant-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch build.sh to die with non-zero exit code in case of errors.
	# This patch may be useful for all ant versions.
	epatch ${FILESDIR}/build.sh-exit-fix.patch
	# This patch will be used until ant 1.6 is released
	epatch ${FILESDIR}/rpmbuild.patch
}

src_compile() {
	addwrite "/proc/self/maps"
	local myclasspath deps

	[ -z ${JDK_HOME} ] && einfo "JDK_HOME not set, please check with java-config" && die

	JAVA_HOME=${JDK_HOME}
	if [ `arch` == "ppc" ] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi

	# Make sure junit tasks get built if we have junit
	if [ -f "/usr/share/junit/lib/junit.jar" ] ; then
		myclasspath="/usr/share/junit/lib/junit.jar"
		deps="junit"
		if [ -f "/usr/share/xalan/lib/xalan.jar" ] ; then
			myclasspath="${myclasspath}:/usr/share/xalan/lib/xalan.jar"
			deps="${deps} xalan"
		fi
	fi

	# Add Xerces in if we have it
	if [ -f "/usr/share/xerces/lib/xercesImpl.jar" ] ; then
		myclasspath="${myclasspath}:/usr/share/xerces/lib/xercesImpl.jar:/usr/share/xerces/lib/xml-apis.jar"
		deps="${deps} xerces"
	fi

	# Add oro in if we have it
	if [ -f "/usr/share/oro/lib/oro.jar" ] ; then
		myclasspath="${myclasspath}:/usr/share/oro/lib/oro.jar"
		deps="${deps} oro"
	fi

	# Add beanutils if we have it
	if [ -f "/usr/share/commons-beanutils/lib/commons-beanutils.jar" ] ; then
		myclasspath="${myclasspath}:/usr/share/commons-beanutils/lib/commons-beanutils.jar"
		deps="${deps} commons-beanutils"
	fi

	# add antlr if we have it
	if [ -f "/usr/share/antlr/lib/antlr.jar" ] ; then
		myclasspath="${myclasspath}:/usr/share/antlr/lib/antlr.jar"
		deps="${deps} antlr"
	fi

	# add bcel if we have it
	if [ -f "/usr/share/bcel/lib/bcel.jar" ] ; then
		myclasspath="${myclasspath}:/usr/share/bcel/lib/bcel.jar"
		deps="${deps} bcel"
	fi

	DEP_APPEND=${deps} CLASSPATH=${myclasspath} \
		./build.sh -Ddist.dir=${D}/usr/share/${PN} || die
}

src_install() {
	cp ${FILESDIR}/${PV}-ant ${S}/src/ant

	exeinto /usr/bin
	doexe src/ant
	for each in antRun runant.pl runant.py complete-ant-cmd.pl ; do
		dobin ${S}/src/script/${each}
	done

	java-pkg_dojar build/lib/*.jar

	use source && java-pkg_dosrc src/main/*

	dodoc README WHATSNEW KEYS
	use doc && dohtml welcome.html
	use doc && java-pkg_dohtml -r docs/*
}
