# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/infobus/infobus-1.2.ebuild,v 1.8 2004/03/18 05:20:42 zx Exp $

inherit java-pkg

DESCRIPTION="InfoBus enables dynamic exchange of data between JavaBeans component architecture."
SRC_URI="ib12.zip"
HOMEPAGE="http://java.sun.com/products/javabeans/infobus/index.html"
KEYWORDS="x86 ppc sparc"
LICENSE="infobus"
SLOT="0"
RESTRICT="fetch"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.2"
IUSE="doc"

S=${WORKDIR}

pkg_nofetch() {
		einfo " "
		einfo " Due to license restrictions, we cannot fetch the"
		einfo " distributables automagically."
		einfo " "
		einfo " 1. Visit ${HOMEPAGE}"
		einfo " 2. Download ${At}"
		einfo " 3. Move file to ${DISTDIR}"
		einfo " 4. Run emerge on this package again to complete"
		einfo " "
		die "User must manually download distfile"
}

src_unpack() {
	unzip -qq ${DISTDIR}/${A}
}

src_compile() { :; }

src_install() {
	use doc && dohtml -r doc/
	dohtml *.html
	java-pkg_dojar infobus.jar
}

