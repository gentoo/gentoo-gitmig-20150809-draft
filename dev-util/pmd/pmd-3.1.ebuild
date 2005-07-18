# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pmd/pmd-3.1.ebuild,v 1.3 2005/07/18 20:54:14 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="PMD is a Java source code analyzer. It finds unused variables, empty catch blocks, unnecessary object creation and so forth."
HOMEPAGE="http://pmd.sourceforge.net"
SRC_URI="mirror://sourceforge/pmd/${PN}-src-${PV}.zip"

LICENSE="pmd"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.3
	=dev-java/jaxen-1.0*
	dev-java/junit
	dev-java/saxpath
	=dev-java/xerces-2.6*"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}/lib/
	rm -f *.jar
	java-pkg_jar-from saxpath
	java-pkg_jar-from jaxen
	java-pkg_jar-from xerces-2
}

src_compile() {
	cd ${S}/bin

	local antflags="dist"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "died on ant"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar

	newbin bin/pmd.sh pmd
	newbin bin/designer.sh pmd-designer
	cp -r rulesets ${D}/usr/share/${PN}

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/*
}

pkg_postinst() {
	einfo ""
	einfo "Various example rulesets can be found under"
	einfo "/usr/share/pmd/rulesets/"
	einfo ""
}
