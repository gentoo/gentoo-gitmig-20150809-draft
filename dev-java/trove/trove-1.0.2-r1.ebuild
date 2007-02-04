# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/trove/trove-1.0.2-r1.ebuild,v 1.3 2007/02/04 14:20:28 nixnut Exp $

inherit java-pkg-2

DESCRIPTION="GNU Trove: High performance collections for Java."
SRC_URI="mirror://sourceforge/trove4j/${P}.tar.gz"
HOMEPAGE="http://trove4j.sourceforge.net"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )"
IUSE="doc source"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f lib/*.jar
	rm -fr javadocs/*
}

src_compile() {
	mkdir build

	cd src
	ejavac -nowarn -d ${S}/build $(find . -name "*.java")

	if use doc ; then
		mkdir ${S}/javadoc
		javadoc -source $(java-pkg_get-source) -quiet -d ${S}/javadoc $(find * -type d | tr '/' '.')
	fi

	cd ${S}

	jar cf lib/${PN}.jar -C build gnu || die "failed too make jar"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc *.txt ChangeLog AUTHORS
	use doc && java-pkg_dohtml -r javadoc
	use source && java-pkg_dosrc src/*
}
