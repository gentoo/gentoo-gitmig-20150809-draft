# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxpath/saxpath-1.0.ebuild,v 1.3 2004/10/17 07:31:05 absinthe Exp $

inherit java-pkg

DESCRIPTION="A Simple API for XPath."
HOMEPAGE="http://saxpath.sourceforge.net/"
SRC_URI="mirror://sourceforge/saxpath/${P}.tar.gz"
LICENSE="saxpath"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc junit"
DEPEND="dev-java/ant
	junit? ( dev-java/junit )
	dev-java/xalan
	>=dev-java/xerces-2.6.2-r1"
#RDEPEND=""

S=${WORKDIR}/${P}-FCS

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar
	mkdir src/conf
	cp ${FILESDIR}/MANIFEST.MF src/conf
	cd lib
	rm -f jakarta-ant-1.3-optional.jar ant-1.3.jar xerces.jar junit.jar
	use junit && java-pkg_jar-from junit
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
}

src_compile() {
	local antops="package"
	use doc && antops="${antops} doc javadoc"
	use junit && antops="${antops} test"
	ant ${antops} || die "failed to compile"
}

src_install() {
	java-pkg_dojar build/saxpath.jar

	use doc && java-pkg_dohtml -r build/doc/*
}
