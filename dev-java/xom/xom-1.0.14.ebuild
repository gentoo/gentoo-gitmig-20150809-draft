# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/xom/xom-1.0.14.ebuild,v 1.2 2003/05/26 08:49:16 absinthe Exp $

inherit java-pkg

#This is ugly but portage barfs with the name set to xom-10.d14
S=${WORKDIR}/XOM
XOMVER="xom-1.0d14"
DESCRIPTION="XOM is a new XML object model. It is a tree-based API for processing XML with Java that strives for correctness and simplicity."
SRC_URI="http://cafeconleche.org/XOM/${XOMVER}.zip"
HOMEPAGE="http://cafeconleche.org/XOM/index.html"
DEPEND=">=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE="doc"

src_compile() {
	local myc
	cd ${WORKDIR}/XOM
	myc="${myc} -Ddebug=off"
	ANT_OPTS=${myc} ant jar || die "Failed Compiling"
}

src_install () {
    mv ${WORKDIR}/XOM/build/${XOMVER}.jar xom.jar
	java-pkg_dojar xom.jar || die "Failed Installing"
	dodoc Todo.txt

	if [ -n "`use doc`" ] ; then
		dodir /usr/share/doc/${P}
		cd ${WORKDIR}/XOM/
		dohtml -r apidocs/
	fi
}
