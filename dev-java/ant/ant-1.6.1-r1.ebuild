# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.6.1-r1.ebuild,v 1.4 2004/03/22 20:12:43 dholm Exp $

inherit java-pkg

DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
SRC_URI="mirror://apache/ant/source/apache-${PN}-${PV}-src.tar.bz2"
HOMEPAGE="http://ant.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
DEPEND="virtual/glibc
	>=virtual/jdk-1.4
	>=dev-java/java-config-1.2
	!<dev-java/ant-optional-${PV}-r1"
RDEPEND=">=virtual/jdk-1.4
	app-shells/bash
	>=dev-java/java-config-1.2"
PDEPEND="=dev-java/ant-optional-${PV}-r1"
IUSE="doc"

S="${WORKDIR}/apache-ant-${PV}"

pkg_setup() {
	if [ -n "$JAVA_HOME" ] ; then
		export CLASSPATH=".:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/jre/lib/rt.jar:."
	else
		einfo "Warning: JAVA_HOME environment variable is not set (or not exported)."
		einfo "  If build fails because sun.* classes could not be found"
		einfo "  you will need to set the JAVA_HOME environment variable"
		einfo "  to the installation directory of java."
		einfo "  Try using java-config script"
		die
	fi

	if [ `arch` == "ppc" ] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch build.sh to die with non-zero exit code in case of errors.
	# This patch may be useful for all ant versions.
	epatch ${FILESDIR}/build.sh-exit-fix.patch.gz
}

src_compile() {
	addwrite "/proc/self/maps"

	local myc
	myc="${myc} -Ddist.dir=${D}/usr/share/ant"
	myc="${myc} -Djavac.target=1.4"

	echo $CLASSPATH
	./build.sh -Ddist.dir=${D}/usr/share/ant || die
}

src_install() {
	cp ${FILESDIR}/${PV}/ant ${S}/src/ant
	exeinto /usr/bin
	doexe src/ant
	for each in antRun runant.pl runant.py complete-ant-cmd.pl ; do
		dobin ${S}/src/script/${each}
	done

	insinto /etc/env.d
	doins ${FILESDIR}/20ant

	java-pkg_dojar build/lib/ant.jar
	java-pkg_dojar build/lib/ant-launcher.jar

	dodoc LICENSE LICENSE.* README WHATSNEW KEYS
	use doc && dohtml welcome.html
	use doc && dohtml -r docs/*
}
