# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/infobus/infobus-1.2.ebuild,v 1.6 2004/01/17 04:45:00 strider Exp $

inherit java-pkg

At="ib12.zip"
S=${WORKDIR}
DESCRIPTION="InfoBus enables dynamic exchange of data between JavaBeans component architecture."
SRC_URI=""
HOMEPAGE="http://java.sun.com/products/javabeans/infobus/index.html"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="infobus"
SLOT="0"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.2"
IUSE="doc"

src_unpack() {
	if [ ! -f "${DISTDIR}/${At}" ] ; then
		echo  " "
		echo  "!!! Missing ${DISTDIR}/${At}"
		echo  " "
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
	fi
	unzip -qq ${DISTDIR}/${At}
}

src_compile() {
	einfo " This is a binary-only ebuild."
}

src_install() {
	use doc && dohtml -r doc/
	dohtml *.html
	java-pkg_dojar infobus.jar
}

