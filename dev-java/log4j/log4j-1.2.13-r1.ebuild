# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.13-r1.ebuild,v 1.3 2006/10/17 02:53:45 nichoj Exp $

inherit java-pkg-2

MY_P="logging-${P}"
DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="mirror://apache/logging/log4j/${PV}/${MY_P}.tar.gz"
HOMEPAGE="http://logging.apache.org/log4j/"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
# jikes support disabled: bug #108819
IUSE="doc javamail jms jmx source"

RDEPEND=">=virtual/jre-1.4
	javamail? ( dev-java/sun-javamail-bin dev-java/sun-jaf-bin )
	jmx? ( dev-java/sun-jmx )
	jms? ( =dev-java/openjms-bin-0.7.6 )"

# We should get log4j working with openjms but at the moment that would bring
# a circular dependency.
#	jms? ( || (=dev-java/openjms-0.7.6* =dev-java/openjms-bin-0.7.6* ))"

# Needs the a newer ant-core because otherwise source 1.1 and target 1.1 fails
# on at least blackdown-jdk-1.4.2.02. The other way to go around this is to 
# explicitly set the javac.source and javac.target properties in the ebuild.

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6.5
	source? ( app-arch/zip )
	${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf dist/
}

src_compile() {
	local antflags="jar"
	use javamail && antflags="${antflags} -Djavamail.jar=$(java-pkg_getjar sun-javamail-bin mail.jar) -Dactivation.jar=$(java-pkg_getjar sun-jaf-bin activation.jar)"
	use jmx && antflags="${antflags} -Djmx.jar=$(java-pkg_getjar sun-jmx jmxri.jar) -Djmx-extra.jar=$(java-pkg_getjar sun-jmx jmxtools.jar)"
	#use jms && antflags="${antflags} -Djms.jar=$(java-pkg_getjar openjms jms.jar)"
	use jms && antflags="${antflags} -Djms.jar=/opt/openjms/lib/jms-1.0.2a.jar"
	eant ${antflags}
}

src_install() {
	java-pkg_newjar dist/lib/${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
