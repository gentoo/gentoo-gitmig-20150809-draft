# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.6.0-r1.ebuild,v 1.1 2003/12/25 17:46:55 strider Exp $

inherit apache-ant java-pkg

IUSE="doc junit regexp oro bsf bsh antlr jdepend js bcel jython"
SUPPORT_JARS="apache-ant-${PV}-support-files.tar.bz2"

S="${WORKDIR}/apache-ant-${PV}"
DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
SRC_URI="mirror://apache/ant/source/apache-${PN}-${PV}-src.tar.bz2 http://dev.gentoo.org/~strider/${SUPPORT_JARS}"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/glibc
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3
	app-shells/bash"
PDEPEND=""

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
	apache-ant_classpath
	apache-ant_compile
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
