# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-lang/commons-lang-1.0.1-r1.ebuild,v 1.3 2003/04/26 05:36:58 strider Exp $

inherit jakarta-commons

S="${WORKDIR}/${PN}-${PV}-src/lang"
DESCRIPTION="Jakarta components to manipulate core java classes"
HOMEPAGE="http://jakarta.apache.org/commons/lang.html"
SRC_URI="mirror://apache/jakarta/commons/lang/source/lang-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="doc jikes junit"

src_compile() {
	cp LICENSE.txt ../LICENSE
	jakarta-commons_src_compile myconf make
	use doc && jakarta-commons_src_compile makedoc
}
