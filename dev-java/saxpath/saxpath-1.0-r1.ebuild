# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxpath/saxpath-1.0-r1.ebuild,v 1.1 2006/08/14 20:17:20 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Simple API for XPath."
HOMEPAGE="http://saxpath.sourceforge.net/"
SRC_URI="mirror://sourceforge/saxpath/${P}.tar.gz"
LICENSE="saxpath"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc junit source"

RDEPEND=">=virtual/jre-1.4
	dev-java/xalan
	>=dev-java/xerces-2.6.2-r1"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	junit? ( dev-java/ant-tasks )
	doc? ( dev-java/ant-tasks )
	${RDEPEND}"

S=${WORKDIR}/${P}-FCS

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar
	mkdir src/conf
	cp ${FILESDIR}/MANIFEST.MF src/conf
	cd lib
	rm -f *.jar
	use junit && java-pkg_jar-from junit
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
}

src_compile() {
	local antops="package"
	use doc && antops="${antops} doc javadoc"
	use junit && antops="${antops} test"
	eant ${antops} || die "failed to compile"
}

src_install() {
	java-pkg_dojar build/saxpath.jar

	use doc && java-pkg_dohtml -r build/doc/*
	use source && java-pkg_dosrc src/java/main/*
}
