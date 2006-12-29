# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgraph/jgraph-5.9.2.0.ebuild,v 1.3 2006/12/29 23:44:56 opfer Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Open-source graph component for Java"
SRC_URI="mirror://sourceforge/${PN}/${P}-lgpl-src.jar"
HOMEPAGE="http://www.${PN}.com"
IUSE="doc examples source"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# don't do javadoc always
	sed -i -e 's/depends="compile, doc"/depends="compile"/' build.xml || \
		die "sed failed"

	rm -rf doc/api
	rm lib/jgraph.jar
}

src_compile() {
	eant jar $(use_doc apidoc)
}

src_install() {
	java-pkg_dojar build/lib/${PN}.jar

	dodoc README WHATSNEW ChangeLog
	use doc && java-pkg_dojavadoc build/doc/api
	use source && java-pkg_dosrc src/org
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r examples/* ${D}/usr/share/doc/${PF}/examples
	fi
}
