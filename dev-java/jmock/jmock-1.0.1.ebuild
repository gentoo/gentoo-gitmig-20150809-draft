# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmock/jmock-1.0.1.ebuild,v 1.2 2005/01/05 09:20:39 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="Library for testing Java code using mock objects."
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${P}-src.jar"
HOMEPAGE="http://jmock.codehaus.org"
LICENSE="BSD"
SLOT="1.0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples jikes"
DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/cglib-2"

src_unpack() {
	jar xf ${DISTDIR}/${A}

	cd ${S}
	epatch ${FILESDIR}/jmock-1.0.1-buildxml.patch

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from cglib-2
}

src_compile() {
	local antflags="core.jar cglib.jar"
	if use doc; then
		antflags="${antflags} javadoc"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar build/dist/jars/*.jar
	dodoc CHANGELOG VERSION LICENSE.txt

	if use doc; then
		java-pkg_dohtml -r build/javadoc-${PV}/*
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r examples/* ${D}/usr/share/doc/${PF}/examples
	fi
}
