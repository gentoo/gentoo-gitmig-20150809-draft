# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-net/commons-net-1.2.2-r1.ebuild,v 1.2 2005/04/02 21:49:52 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="The purpose of the library is to provide fundamental protocol access, not higher-level abstractions."
HOMEPAGE="http://jakarta.apache.org/commons/net/"
SRC_URI="mirror://apache/jakarta/commons/net/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-core-1.5.4
		=dev-java/jakarta-oro-2.0*
		jikes? ( dev-java/jikes )
		source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc jikes source"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-1.2.diff
	#for some reason 1.2.2 claims its 1.3
	sed "s/commons-net-1.3.0-dev/commons-net-1.2.2-dev/" -i build.xml || die "died on sed"
}

src_compile() {
	local antflags="-Doro.jar=$(java-config -p jakarta-oro-2.0) jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "died on ant"
}

src_install() {
	mv ${S}/target/${P}-dev.jar ${S}/target/${PN}.jar
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/
	use source && java-pkg_dosrc src/java/org
}
