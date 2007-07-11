# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fastutil/fastutil-4.3.1.ebuild,v 1.9 2007/07/11 19:58:37 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="Provides type-specific maps, sets and lists with a small memory footprint for much faster access and insertion."
SRC_URI="http://fastutil.dsi.unimi.it/${P}-src.tar.gz"
HOMEPAGE="http://fastutil.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="4.3"
IUSE="doc jikes"
KEYWORDS="x86 ppc amd64"

DEPEND=">=virtual/jdk-1.4
	 dev-java/ant-core
	 jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	make sources || die "failed to make sources"

	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r docs/*
	dodoc CHANGES README
}
