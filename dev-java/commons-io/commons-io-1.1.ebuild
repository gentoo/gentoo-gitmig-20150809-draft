# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-io/commons-io-1.1.ebuild,v 1.1 2005/12/04 18:38:25 nichoj Exp $

inherit java-pkg eutils

MY_P="${P}-src"
DESCRIPTION="Commons-IO contains utility classes  , stream implementations, file filters  , and endian classes."
HOMEPAGE="http://jakarta.apache.org/commons/io"
SRC_URI="mirror://apache/jakarta/commons/io/source/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc jikes source"

DEPEND="jikes? ( >=dev-java/jikes-1.21 )
	dev-java/ant-core
	source? ( app-arch/zip )
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${MY_P}"

# junit tests are disabled for now.
# one of the tests (FileUtilsCleanDirectoryTestCase) always fails when run as
# root.
# TODO report upstream

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	mkdir -p build/lib
	cd build/lib
#	use junit && java-pkg_jar-from junit
}

src_compile() {
	local antflags="jar -Dlibdir=build/lib"
	use doc && antflags="${antflags} javadoc -Djavadocdir=dist/docs/api"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
#	use junit && antflags="${antflags} test"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt NOTICE.txt
	dohtml PROPOSAL.html STATUS.html usersguide.html
	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
