# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mockobjects/mockobjects-0.09-r1.ebuild,v 1.3 2005/07/15 11:35:08 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="Test-first development process for building object-oriented software"
HOMEPAGE="http://mockobjects.sf.net"
SRC_URI="http://dev.gentoo.org/~karltk/java/distfiles/mockobjects-java-${PV}-gentoo.tar.bz2"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc jikes junit source"

DEPEND=">=virtual/jdk-1.4
	junit? ( =dev-java/junit-3.8* )
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )
	>=dev-java/ant-core-1.6.2"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/mockobjects-java-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.patch

	if use junit; then
		cd lib
		java-pkg_jar-from junit
	fi
	cd ${S}
	mkdir -p out/jdk/classes
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} junit"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_newjar out/${PN}-alt-jdk1.4-${PV}.jar ${PN}-alt-jdk1.4.jar
	java-pkg_newjar out/${PN}-jdk1.4-${PV}.jar ${PN}-jdk1.4.jar
	java-pkg_newjar out/${PN}-core-${PV}.jar ${PN}-core.jar
	dodoc doc/README

	use doc && java-pkg_dohtml -r out/doc/javadoc/*
	use source && java-pkg_dosrc ${S}/src/*
}
