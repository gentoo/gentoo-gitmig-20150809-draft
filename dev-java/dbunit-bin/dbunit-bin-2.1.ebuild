# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dbunit-bin/dbunit-bin-2.1.ebuild,v 1.3 2004/10/22 10:55:26 absinthe Exp $

inherit java-pkg

DESCRIPTION="DBUnit is a JUnit extension targeted for database-driven projects that, puts your database into a known state between test runs."
MY_P=${P/-bin}
MY_PN=${PN/-bin}
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.zip"
HOMEPAGE="http://www.dbunit.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.3"
IUSE="doc"

S=${WORKDIR}/${MY_P}

src_compile() {	:; }

src_install() {
	mv ${S}/${MY_P}.jar ${S}/${MY_PN}.jar
	java-pkg_dojar ${MY_PN}.jar
	use doc && java-pkg_dohtml -r docs/*
}
