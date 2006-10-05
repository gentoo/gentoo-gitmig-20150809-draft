# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.9.ebuild,v 1.15 2006/10/05 18:05:36 gustavoz Exp $

inherit java-pkg

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="mirror://apache/logging/log4j/${PV}/logging-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 amd64 ppc64 ppc"
IUSE="doc javamail jikes jms jmx source"

RDEPEND=">=virtual/jre-1.4
	javamail? ( dev-java/sun-javamail-bin dev-java/sun-jaf-bin )
	jmx? ( dev-java/sun-jmx )
	jms? ( =dev-java/openjms-bin-0.7.6 )"
	#jms? ( =dev-java/openjms-0.7.6 )"
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

	# Fix for failure without JMX
	use jmx || rm -rf ${S}/src/java/org/apache/log4j/jmx
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use javamail && antflags="${antflags} -Djavamail.jar=$(java-pkg_getjar sun-javamail-bin mail.jar) -Dactivation.jar=$(java-pkg_getjar sun-jaf-bin activation.jar)"
	use jmx && antflags="${antflags} -Djmx.jar=$(java-pkg_getjar sun-jmx jmxri.jar) -Djmx-extra.jar=$(java-pkg_getjar sun-jmx jmxtools.jar)"
	#use jms && antflags="${antflags} -Djms.jar=$(java-pkg_getjar openjms jms.jar)"
	use jms && antflags="${antflags} -Djms.jar=/opt/openjms/lib/jms-1.0.2a.jar"
	ant ${antflags} || die "compilation error"
}

src_install() {
	java-pkg_newjar dist/lib/log4j-${PV}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}

