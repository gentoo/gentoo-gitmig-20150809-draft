# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kunststoff/kunststoff-2.0.2.ebuild,v 1.2 2005/02/04 23:24:14 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Kunststoff Look&Feel"
SRC_URI="http://www.incors.org/archive/${P//./_}.zip"
HOMEPAGE="http://www.incors.org/archive"
LICENSE="LGPL-2.1"
SLOT="2.0"
KEYWORDS="x86 amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}

	rm -f *.jar
	cp ${FILESDIR}/build.xml .
}

src_compile() {
	local antflags="jar"
	if use doc; then
		antflags="${antflags} docs"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/kunststoff.jar

	dodoc licence.txt
	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}
