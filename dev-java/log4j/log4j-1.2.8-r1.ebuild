# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.8-r1.ebuild,v 1.1 2004/09/17 09:29:06 axxo Exp $

inherit java-pkg

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="http://jakarta.apache.org/log4j/jakarta-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.2"
S="${WORKDIR}/jakarta-${P}"

src_compile() { :; }

src_install() {
	cd dist/lib
	mv log4j-${PV}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar
	use doc && dohtml -r docs/*
}

