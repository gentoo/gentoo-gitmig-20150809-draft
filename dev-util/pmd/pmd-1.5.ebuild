# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pmd/pmd-1.5.ebuild,v 1.6 2004/11/03 11:49:15 axxo Exp $

inherit java-pkg

DESCRIPTION="PMD is a Java source code analyzer. It finds unused variables, empty catch blocks, unnecessary object creation and so forth."
HOMEPAGE="http://pmd.sourceforge.net"
SRC_URI="mirror://sourceforge/pmd/${PN}-src-${PV}.zip"
LICENSE="pmd"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="doc"

DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	>=dev-java/ant-1.5
	>=dev-java/junit-3.8.1"

RDEPEND="|| ( >=virtual/jdk-1.3 >=virtual/jre-1.3 )"

src_compile() {
	cd etc
	ant standalone-jar || die "died on ant"
}

src_install() {
	java-pkg_dojar etc/${PN}.jar
	use doc && java-pkg_dohtml -r docs/*
}
