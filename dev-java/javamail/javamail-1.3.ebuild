# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javamail/javamail-1.3.ebuild,v 1.2 2003/05/24 06:56:46 absinthe Exp $

inherit java-pkg

At="${PN}-${PV/./_}.zip"
S=${WORKDIR}/${P}
DESCRIPTION="A Java-based framework to build multiplatform mail and messaging applications."
SRC_URI=""
HOMEPAGE="http://java.sun.com/products/javamail/index.html"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"
LICENSE="sun-bcla-javamail"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2
	>=dev-java/jaf-1.0.2"
IUSE="doc"
DEP_APPEND="jaf"

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
	dodoc CHANGES.txt README.txt LICENSE.txt NOTES.txt
	use doc && dohtml -r docs/
	java-pkg_dojar mail.jar lib/*.jar
}

