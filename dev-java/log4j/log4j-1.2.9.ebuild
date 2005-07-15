# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.9.ebuild,v 1.11 2005/07/15 09:54:33 axxo Exp $

inherit java-pkg

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="mirror://apache/logging/log4j/${PV}/logging-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 amd64 ppc64 sparc ppc"
IUSE="doc javamail jikes jms jmx source"

RDEPEND=">=virtual/jre-1.4
	javamail? ( dev-java/sun-javamail-bin dev-java/sun-jaf-bin )
	jmx? ( dev-java/jmx )
	jms? ( =dev-java/openjms-bin-0.7.6 )"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )
	${RDEPEND}"

S="${WORKDIR}/logging-${P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf dist/
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use javamail && antflags="${antflags} -Djavamail.jar=$(java-pkg_getjar sun-javamail-bin mail.jar) -Dactivation.jar=$(java-pkg_getjar sun-jaf-bin activation.jar)"
	use jmx && antflags="${antflags} -Djmx.jar=$(java-pkg_getjar jmx jmxri.jar) -Djmx-extra.jar=$(java-pkg_getjar jmx jmxtools.jar)"
	use jms && antflags="${antflags} -Djms.jar=$(java-pkg_getjar openjms jms.jar)"
	ant ${antflags} || die "compilation error"
}

src_install() {
	java-pkg_newjar dist/lib/log4j-${PV}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}

