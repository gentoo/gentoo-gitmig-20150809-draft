# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jacl/jacl-1.3.1.ebuild,v 1.8 2005/07/16 11:51:30 axxo Exp $

inherit java-pkg

DESCRIPTION="Jacl is an implementation of Tcl written in Java."
HOMEPAGE="http://tcljava.sourceforge.net"
SRC_URI="mirror://sourceforge/tcljava/${P//-}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64"

IUSE="jikes doc"

RDEPEND=">=dev-lang/tcl-8.4.5
	>=virtual/jre-1.1"
DEPEND=">=virtual/jdk-1.1
	${RDEPEND}
	jikes? ( >=dev-java/jikes-1.19 )"

S=${WORKDIR}/${P//-}

src_compile() {
	econf --enable-jacl $(use_with jikes) || die
	emake DESTDIR="/usr/share/${PN}" || die "emake failed"
}

src_install() {
	java-pkg_dojar *.jar
	dobin jaclsh
	dodoc README ChangeLog known_issues.txt new_features.txt

	use doc && java-pkg_dohtml -r docs/*
}
