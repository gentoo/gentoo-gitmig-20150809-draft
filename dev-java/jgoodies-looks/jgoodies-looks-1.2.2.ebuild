# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks/jgoodies-looks-1.2.2.ebuild,v 1.2 2005/01/06 21:04:16 luckyduck Exp $

inherit java-pkg

DESCRIPTION="JGoodies Looks Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-1_2_2.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"

DEPEND=">=virtual/jre-1.4
		>=dev-java/ant-core-1.4
		  app-arch/unzip
		jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/looks-1.2.2"

src_unpack() {
	unpack ${A}
	cd ${S}

	rm *.jar
	unzip looks-1.2.2-src.zip &> /dev/null || die "Unpack Failed"
	cp ${FILESDIR}/build.xml ${FILESDIR}/plastic.txt .
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_dojar looks.jar

	dodoc LICENSE.txt RELEASE-NOTES.txt
	if use doc ; then
		java-pkg_dohtml -r build/doc
	fi
}
