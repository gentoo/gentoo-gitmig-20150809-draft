# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks/jgoodies-looks-1.3_beta1.ebuild,v 1.2 2005/03/30 18:59:54 compnerd Exp $

inherit java-pkg

DESCRIPTION="JGoodies Looks Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-1_3_b1-20050108.zip"

LICENSE="BSD"
SLOT="1.3"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4.2
		>=dev-java/ant-core-1.4
		  app-arch/unzip
		jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4.2"

S="${WORKDIR}/looks-1.3b1"

src_unpack() {
	unpack ${A}
	cd ${S}

	rm *.jar
	mkdir ${S}/srcdir
	unzip -d ${S}/srcdir -q looks-1.3b1-src.zip  || die "Unpack Failed"
	cp ${FILESDIR}/${PV}-build.xml ./build.xml
	cp ${FILESDIR}/plastic.txt .
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_dojar dist/looks.jar

	dodoc LICENSE.txt RELEASE-NOTES.txt
	if use doc ; then
		java-pkg_dohtml -r build/doc
	fi
}
