# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-net/commons-net-1.3.0-r1.ebuild,v 1.2 2005/04/02 21:49:52 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="The purpose of the library is to provide fundamental protocol access, not higher-level abstractions."
HOMEPAGE="http://jakarta.apache.org/commons/net/"
SRC_URI="mirror://apache/jakarta/commons/net/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.5.4
	>=dev-java/jakarta-oro-2.0*
	junit? ( dev-java/junit )
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ppc64"
IUSE="doc examples jikes junit source"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's|depends="get-deps"||' build.xml || die "sed failed"
	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from jakarta-oro-2.0 jakarta-oro.jar oro.jar

	cd ${S}
	if ! use junit ; then
			sed -i 's/depends="compile,test"/depends="compile"/' \
				build.xml || die "Failed to disable junit"
	else
		if ! has_version dev-java/ant-tasks; then
			sed -i 's/depends="compile,test"/depends="compile"/' \
				build.xml || die "Failed to disable junit"
		fi
	fi
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "died on ant"
}

src_install() {
	mv ${S}/target/${P}-dev.jar ${S}/target/${PN}.jar
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/java/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/java/org
}
