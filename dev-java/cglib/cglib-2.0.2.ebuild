# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.0.2.ebuild,v 1.4 2005/01/05 22:25:29 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library, It is used to extend JAVA classes and implements interfaces at runtime."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-1.1"
SLOT="2"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=virtual/jre-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	=dev-java/asm-1.4*
	=dev-java/aspectwerkz-2*"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5"
IUSE="doc jikes"

S=${WORKDIR}

src_unpack() {
	jar xf ${DISTDIR}/${A} || die "failed to unpack"

	epatch ${FILESDIR}/${P}-asm-1.4.3.patch

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from asm-1.4
	java-pkg_jar-from aspectwerkz-2
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "builed to build"
}

src_install() {
	mv dist/${PN}-${PV}.jar dist/${PN}.jar
	mv dist/${PN}-full-${PV}.jar dist/${PN}-full.jar
	java-pkg_dojar dist/${PN}.jar dist/${PN}-full.jar

	dodoc LICENSE NOTICE README
	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}
