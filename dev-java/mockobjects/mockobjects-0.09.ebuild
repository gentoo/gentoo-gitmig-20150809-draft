# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mockobjects/mockobjects-0.09.ebuild,v 1.8 2005/01/04 18:44:36 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="Test-first development process for building object-oriented software"
HOMEPAGE="http://mockobjects.sf.net"
SRC_URI="http://dev.gentoo.org/~karltk/java/distfiles/mockobjects-java-${PV}-gentoo.tar.bz2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
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
	mkdir -p out/jdk/classes
}

src_compile() {
	local antflags="jar"
	if use doc; then
		antflags="${antflags} javadoc"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	if use junit; then
		antflags="${antflags} junit"
	fi
	if use source; then
		antflags="${antflags} sourcezip"
	fi
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar out/*.jar
	dodoc doc/README

	if use doc; then
		java-pkg_dohtml -r out/doc/javadoc/*
	fi
	if use source; then
		dodir /usr/share/doc/${PF}/source
		cp out/${PN}-src.zip ${D}/usr/share/doc/${PF}/source
	fi
}
