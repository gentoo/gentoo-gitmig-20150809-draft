# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaf-bin/sun-jaf-bin-1.0.2.ebuild,v 1.4 2004/07/14 13:18:33 agriffis Exp $

inherit java-pkg

At="jaf-1_0_2-upd.zip"
DESCRIPTION="Sun's JavaBeans Activation Framework (JAF)"
SRC_URI="${At}"
HOMEPAGE="http://java.sun.com/products/javabeans/glasgow/jaf.html"
KEYWORDS="x86 ppc sparc amd64"
LICENSE="sun-bcla-jaf"
SLOT="0"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.2"
IUSE="doc"
RESTRICT="fetch"
S=${WORKDIR}/jaf-${PV}

pkg_nofetch() {
	einfo " "
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo " "
	einfo " 1. Visit ${HOMEPAGE}"
	einfo " 2. Download ${At}"
	einfo " 3. Move file to ${DISTDIR}"
	einfo " "
}

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
	dodoc RELNOTES.txt README.txt LICENSE.txt
	use doc && dohtml -r docs/
	java-pkg_dojar activation.jar
}
