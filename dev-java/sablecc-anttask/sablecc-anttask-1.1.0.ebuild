# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sablecc-anttask/sablecc-anttask-1.1.0.ebuild,v 1.4 2004/10/22 10:11:06 absinthe Exp $

inherit java-pkg

DESCRIPTION="Ant task for sablecc"

HOMEPAGE="http://sablecc.org/"
SRC_URI="mirror://sourceforge/sablecc/${P}-src.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=virtual/jdk-1.4
		dev-java/sablecc
		dev-java/ant"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	ant jar || die "failed to compile"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodir /usr/share/ant-core/lib/
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/
	java-pkg_dohtml -r doc
	dodoc AUTHORS ChangeLog COPYING-LESSER LICENSE README
}
