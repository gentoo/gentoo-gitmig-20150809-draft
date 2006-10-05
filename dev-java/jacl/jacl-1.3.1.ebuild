# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jacl/jacl-1.3.1.ebuild,v 1.11 2006/10/05 17:17:31 gustavoz Exp $

inherit java-pkg

DESCRIPTION="Jacl is an implementation of Tcl written in Java."
HOMEPAGE="http://tcljava.sourceforge.net"
SRC_URI="mirror://sourceforge/tcljava/${P//-}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE="doc"

RDEPEND=">=dev-lang/tcl-8.4.5
	>=virtual/jre-1.1"
DEPEND=">=virtual/jdk-1.1
	${RDEPEND}"


S=${WORKDIR}/${P//-}

# jikes support disabled for now.
# refer to bug #100020 and bug #89711

src_compile() {
	econf --enable-jacl --without-jikes || die
	emake DESTDIR="/usr/share/${PN}" || die "emake failed"
}

src_install() {
	java-pkg_dojar *.jar
	dobin jaclsh
	dodoc README ChangeLog known_issues.txt new_features.txt

	use doc && java-pkg_dohtml -r docs/*
}
