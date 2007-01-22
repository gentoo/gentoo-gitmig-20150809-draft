# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-io/commons-io-1.2.ebuild,v 1.4 2007/01/22 12:39:23 caster Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_P="${P}-src"
DESCRIPTION="Commons-IO contains utility classes  , stream implementations, file filters  , and endian classes."
HOMEPAGE="http://jakarta.apache.org/commons/io"
SRC_URI="mirror://apache/jakarta/commons/io/source/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source test"

DEPEND="dev-java/ant-core
	source? ( app-arch/zip )
	test? ( dev-java/junit dev-java/ant-tasks )
	>=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	rm -v *.jar
	epatch ${FILESDIR}/${P}-gentoo.diff
	java-ant_ignore-system-classes
	java-ant_rewrite-classpath
}

# one of the tests (FileUtilsCleanDirectoryTestCase) used to always fail
# when run as root, but I could not get this behaviour any more.

src_test() {
	eant test -Dgentoo.classpath="$(java-pkg_getjars junit)" \
		-DJunit.present=true
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt NOTICE.txt || die
	use doc && java-pkg_dojavadoc build/dist-build/${P}/docs
	use source && java-pkg_dosrc src/java/*
}
