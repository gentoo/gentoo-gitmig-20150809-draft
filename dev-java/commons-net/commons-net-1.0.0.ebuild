# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-net/commons-net-1.0.0.ebuild,v 1.3 2003/04/26 05:36:58 strider Exp $

inherit jakarta-commons

S="${WORKDIR}/${P}"
DESCRIPTION="The purpose of the library is to provide fundamental protocol access, not higher-level abstractions."
HOMEPAGE="http://jakarta.apache.org/commons/net/index.html"
SRC_URI="mirror://apache/jakarta/commons/net/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="doc jikes junit"

src_compile() {
	jakarta-commons_src_compile myconf make
	jakarta-commons_src_install dojar
	use doc && jakarta-commons_src_compile makedoc
	use doc && jakarta-commons_src_install html
}
