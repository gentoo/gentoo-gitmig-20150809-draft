# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jal/jal-20031117-r2.ebuild,v 1.3 2005/07/15 13:54:45 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="Partial port of the C++ Standard Template Library."
SRC_URI="http://vigna.dsi.unimi.it/jal/${P}-src.tar.gz"
HOMEPAGE="http://vigna.dsi.unimi.it/jal/"

LICENSE="X11"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	>=dev-java/fastutil-3.1"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/buildxml.patch

	# we have to generate the sources first
	./instantiate -n byte bytes
	./instantiate -n short shorts
	./instantiate -n char chars
	./instantiate -n int ints
	./instantiate -n long longs
	./instantiate -n float floats
	./instantiate -n double doubles
	./instantiate Object objects
	./instantiate String strings
	mkdir -p src/jal
	mv bytes shorts chars ints longs floats doubles objects strings src/jal

}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc ${S}/src/jal
}

