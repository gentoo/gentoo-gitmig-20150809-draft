# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-net/commons-net-1.3.0.ebuild,v 1.8 2005/01/26 21:48:15 corsair Exp $

inherit eutils java-pkg

DESCRIPTION="The purpose of the library is to provide fundamental protocol access, not higher-level abstractions."
HOMEPAGE="http://jakarta.apache.org/commons/net/"
SRC_URI="mirror://apache/jakarta/commons/net/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.5.4
	>=dev-java/oro-2.0.7
	junit? ( dev-java/junit )
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ppc64"
IUSE="jikes doc junit"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's|depends="get-deps"||' build.xml || die "sed failed"
	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from oro

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
	java-pkg_dojar target/${PN}.jar || die "died on java-pkg_dojar"
	use doc && java-pkg_dohtml -r dist/docs/
}
