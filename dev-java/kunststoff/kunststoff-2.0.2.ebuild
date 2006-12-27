# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kunststoff/kunststoff-2.0.2.ebuild,v 1.5 2006/12/27 23:34:41 dertobi123 Exp $

inherit java-pkg

DESCRIPTION="Kunststoff Look&Feel"
SRC_URI="http://www.incors.org/archive/${P//./_}.zip"
HOMEPAGE="http://www.incors.org/archive"
LICENSE="LGPL-2.1"
SLOT="2.0"
KEYWORDS="amd64 ppc x86"
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
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/kunststoff.jar

	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}
