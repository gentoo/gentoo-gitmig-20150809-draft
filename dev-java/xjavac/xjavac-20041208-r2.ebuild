# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xjavac/xjavac-20041208-r2.ebuild,v 1.1 2006/07/20 23:55:12 nichoj Exp $

inherit java-pkg-2

DESCRIPTION="The implementation of the javac compiler for IBM JDK 1.4 (needed for xerces-2)"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://cvs.apache.org/viewcvs.cgi/xml-xerces/java/tools/src/XJavac.java"
LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4"
RDEPEND=">=virtual/jdk-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/${P}-build.xml ./build.xml || die
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodir /usr/share/ant-core/lib/
	dosym /usr/share/${PN}-${SLOT}/lib/${PN}.jar /usr/share/ant-core/lib/
}
