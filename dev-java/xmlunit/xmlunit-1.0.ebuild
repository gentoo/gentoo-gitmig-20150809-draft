# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlunit/xmlunit-1.0.ebuild,v 1.2 2005/02/18 16:03:55 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="XMLUnit extends JUnit and NUnit to enable unit testing of XML."
SRC_URI="mirror://sourceforge/${PN}/${P/-/}.zip"
HOMEPAGE="http://xmlunit.sourceforge.net/"
LICENSE="BSD"
SLOT="1"
KEYWORDS="x86 amd64"
IUSE="doc jikes junit source"
DEPEND=">=virtual/jdk-1.3
	jikes? ( >=dev-java/jikes-1.21 )
	source?( app-arch/zip )
	junit? ( dev-java/junit )
	>=app-arch/unzip-5.50-r1
	>=dev-java/ant-1.6"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}/lib
	rm -f *.jar
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	use source && antflags="${antflags} sourcezip"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc LICENSE.txt README.txt

	if use source; then
		dodir /usr/share/doc/${PF}/source
		cp ${PN}-src.zip ${D}usr/share/doc/${PF}/source
	fi
	if use doc; then
		java-pkg_dohtml -r doc/*
	fi
}
