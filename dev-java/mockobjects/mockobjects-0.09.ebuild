# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mockobjects/mockobjects-0.09.ebuild,v 1.7 2004/10/17 19:17:41 axxo Exp $

inherit java-pkg

DESCRIPTION="Test-first development process for building object-oriented software"
HOMEPAGE="http://mockobjects.sf.net"
SRC_URI="http://dev.gentoo.org/~karltk/java/distfiles/mockobjects-java-${PV}-gentoo.tar.bz2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="doc junit"
DEPEND="=dev-java/junit-3.8*"
RDEPEND=""
S=${WORKDIR}/mockobjects-java-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/build.xml-${PV} build.xml || die
	(
		cd lib
		java-pkg_jar-from junit
	)
	mkdir -p out/jdk/classes
}

src_compile() {
	# karltk: add jikes support soon
	ant jar || die "failed to build jar"
	if use doc ; then
		ant javadoc || die "failed to create javadoc"
	fi
	if use junit ; then
		ant junit || die "failed to run junit"
	fi
}

src_install() {
	java-pkg_dojar out/*.jar
	dodoc doc/README
	java-pkg_dohtml -r out/doc/javadoc/*
}
