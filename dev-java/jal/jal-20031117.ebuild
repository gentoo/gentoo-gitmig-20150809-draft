# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jal/jal-20031117.ebuild,v 1.7 2004/12/04 12:49:34 karltk Exp $

inherit eutils java-pkg

DESCRIPTION="Jal is a partial port of the STL by the C++ Standard Template Library."
SRC_URI="http://vigna.dsi.unimi.it/jal/${P}-src.tar.gz"
HOMEPAGE="http://vigna.dsi.unimi.it/jal/"
LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/fastutil-3.1"

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

src_compile () {
	local antflags="jar"
	if use doc; then
		antflags="${antflags} javadoc"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags}
}

src_install() {
	java-pkg_dojar ${PN}.jar
	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}

