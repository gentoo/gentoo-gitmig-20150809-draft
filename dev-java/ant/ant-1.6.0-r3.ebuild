# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.6.0-r3.ebuild,v 1.10 2004/08/27 18:29:39 sejo Exp $

inherit java-pkg eutils

DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
HOMEPAGE="http://ant.apache.org/"
SRC_URI="mirror://apache/ant/source/apache-${PN}-${PV}-src.tar.bz2"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ppc"
IUSE="doc"

DEPEND="virtual/libc
	>=virtual/jdk-1.4
	>=dev-java/java-config-1.2
	!<dev-java/${PF}"
RDEPEND=">=virtual/jdk-1.4
	app-shells/bash
	>=dev-java/java-config-1.2"
PDEPEND="=dev-java/ant-optional-1.6.0-r3"

S="${WORKDIR}/apache-ant-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch build.sh to die with non-zero exit code in case of errors.
	# This patch may be useful for all ant versions.
	epatch ${FILESDIR}/build.sh-exit-fix.patch.gz
}

src_compile() {
	addwrite "/proc/self/maps"
	export JAVA_HOME=${JDK_HOME}
	if [ `arch` == "ppc" ] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi

	./build.sh -Ddist.dir=${D}/usr/share/ant || die
}

src_install() {
	cp ${FILESDIR}/${PV}-${PR}/ant ${S}/src/ant
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
