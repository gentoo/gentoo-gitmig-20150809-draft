# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jabref/jabref-1.5.ebuild,v 1.4 2004/10/26 13:36:58 axxo Exp $

inherit java-pkg

DESCRIPTION="GUI frontend for BibTeX, written in Java"
HOMEPAGE="http://jabref.sourceforge.net/"
SRC_URI="mirror://sourceforge/jabref/Jabref-${PV}-src.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4
	sys-apps/sed
	>=dev-java/ant-1.4.1
	>=dev-java/antlr-2.7.3
	>=dev-java/jgoodies-looks-bin-1.2.2
	>=sys-apps/sed-4
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f antlr.jar looks-*.jar

	java-pkg_jar-from antlr
	java-pkg_jar-from jgoodies-looks-bin

	cd ${S}
	sed -i 's:looks-1.2.2.jar:jgoodies-looks-bin.jar:' build.xml || die "sed failed"
}


src_compile() {
	local antflags="compile unjarlib jars"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar build/lib/${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /usr/share/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -jar lib/${PN}.jar '$*' >> ${PN}

	dobin ${PN}
}
