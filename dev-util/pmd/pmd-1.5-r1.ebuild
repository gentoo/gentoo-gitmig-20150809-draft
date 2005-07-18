# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pmd/pmd-1.5-r1.ebuild,v 1.5 2005/07/18 20:54:14 axxo Exp $

inherit java-pkg

DESCRIPTION="PMD is a Java source code analyzer. It finds unused variables, empty catch blocks, unnecessary object creation and so forth."
HOMEPAGE="http://pmd.sourceforge.net"
SRC_URI="mirror://sourceforge/pmd/${PN}-src-${PV}.zip"
LICENSE="pmd"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.3
	=dev-java/jaxen-1.0*
	dev-java/saxpath
	>=dev-java/xerces-2.6.2-r1"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	app-arch/unzip
	dev-java/ant
	>=dev-java/junit-3.8.1"

src_unpack() {
	unpack ${A}
	cd ${S}/lib/
	rm -f *.jar
	java-pkg_jar-from saxpath saxpath.jar saxpath-1.0-fcs.jar
	java-pkg_jar-from jaxen jaxen-full.jar jaxen-core-1.0-fcs.jar
	java-pkg_jar-from xerces-2
	cd ${S}
}

src_compile() {
	cd etc
	ant standalone-jar || die "died on ant"
}

src_install() {
	java-pkg_dojar etc/${PN}.jar
	use doc && java-pkg_dohtml -r docs/*
}
