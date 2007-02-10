# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-lang/commons-lang-2.0-r2.ebuild,v 1.8 2007/02/10 18:34:59 nixnut Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jakarta components to manipulate core java classes"
HOMEPAGE="http://jakarta.apache.org/commons/lang/"
SRC_URI="mirror://apache/jakarta/commons/lang/source/${P}-src.tar.gz"
DEPEND="
	!doc? ( >=virtual/jdk-1.4 )
	doc? ( || ( =virtual/jdk-1.4* =virtual/jdk-1.5* ) )
	>=dev-java/ant-core-1.4
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc source"

S="${WORKDIR}/${P}-src"

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt
	java-pkg_dohtml DEVELOPERS-GUIDE.html PROPOSAL.html STATUS.html
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
