# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fastutil/fastutil-4.4.1.ebuild,v 1.1 2005/04/15 13:07:50 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Provides type-specific maps, sets and lists with a small memory footprint for much faster access and insertion."
SRC_URI="http://fastutil.dsi.unimi.it/${P}-src.tar.gz"
HOMEPAGE="http://fastutil.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="4.4"
IUSE="doc jikes source"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

DEPEND=">=virtual/jdk-1.4
	 >=dev-java/ant-core-1.6
	 jikes? ( dev-java/jikes )
	 source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	make sources || die "failed to make sources"

	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	mv ${P}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	if use doc; then
		java-pkg_dohtml -r docs/*
		dodoc CHANGES README
	fi
	use source && java-pkg_dosrc java/it
}

