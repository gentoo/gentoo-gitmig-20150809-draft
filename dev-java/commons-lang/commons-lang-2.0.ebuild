# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-lang/commons-lang-2.0.ebuild,v 1.2 2004/03/01 04:53:48 zx Exp $

inherit jakarta-commons

S="${WORKDIR}/${PN}-${PV}-src"
DESCRIPTION="Jakarta components to manipulate core java classes"
HOMEPAGE="http://jakarta.apache.org/commons/lang.html"
SRC_URI="mirror://apache/jakarta/commons/lang/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="doc jikes junit"

src_compile() {
	cp LICENSE.txt ../LICENSE
	jakarta-commons_src_compile myconf make
	use doc && jakarta-commons_src_compile makedoc
}
