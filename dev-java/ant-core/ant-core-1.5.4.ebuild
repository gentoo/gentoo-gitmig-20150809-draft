# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-core/ant-core-1.5.4.ebuild,v 1.1 2004/09/10 19:45:18 axxo Exp $

inherit java-pkg eutils

MY_PN=${PN/-core}
DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
HOMEPAGE="http://ant.apache.org/"
SRC_URI="http://archive.apache.org/dist/ant/source/apache-${MY_PN}-${PV}-src.zip"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc"

DEPEND="virtual/libc
	>=virtual/jdk-1.3
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.3
	app-shells/bash"

S="${WORKDIR}/apache-ant-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch build.sh to die with non-zero exit code in case of errors.
	# This patch may be useful for all ant versions.
	epatch ${FILESDIR}/build.sh-exit-fix.patch.gz
	# This patch will be used until ant 1.6 is released
	epatch ${FILESDIR}/rpmbuild.patch.gz
}

src_compile() {
	addwrite "/proc/self/maps"

	[ -z ${JDK_HOME} ] && einfo "JDK_HOME not set, please check with java-config" && die

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

	# add bcel if we have it
	if [ -f "/usr/share/bcel/lib/bcel.jar" ] ; then
		export CLASSPATH="${CLASSPATH}:/usr/share/bcel/lib/bcel.jar"
		export DEP_APPEND="${DEP_APPEND} bcel"
	fi

	./build.sh -Ddist.dir=${D}/usr/share/${PN} || die
}

src_install() {
	cp ${FILESDIR}/${PVR}-ant ${S}/src/ant

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
