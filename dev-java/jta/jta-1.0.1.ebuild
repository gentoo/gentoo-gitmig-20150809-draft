# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jta/jta-1.0.1.ebuild,v 1.5 2004/10/17 07:29:48 absinthe Exp $

inherit java-pkg

At="jta-1_0_1B-classes.zip"
DESCRIPTION="The Java Transaction API (old and only really needed to build tomcat)"
HOMEPAGE="http://java.sun.com/products/jta/"
SRC_URI="${At}"
LICENSE="sun-bcla-jta"
SLOT=0
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE=""
DEPEND=">=app-arch/unzip-5.50-r1
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
RESTRICT="fetch"

pkg_nofetch() {
	einfo " "
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo " "
	einfo " 1. Visit ${HOMEPAGE}"
	einfo " 2. Select 'Java Transaction API Specification 1.0.1B Class Files 1.0.1B'"
	einfo " 3. Download ${At}"
	einfo " 4. Move file to ${DISTDIR}"
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
		einfo " 1. Visit ${HOMEPAGE} and select 'Downloads'"
		einfo " 2. Select 'Java Transaction API Specification 1.0.1B Class Files 1.0.1B'"
		einfo " 3. Download ${At}"
		einfo " 4. Move file to ${DISTDIR}"
		einfo " 5. Run emerge on this package again to complete"
		einfo " "
		die "User must manually download distfile"
	fi
	unzip -qq ${DISTDIR}/${At}
}

src_compile() {
	einfo " This is a binary-only ebuild."
	einfo "Adding class files to a jar file."
	cd ${WORKDIR}
	jar cvf jta.jar javax/
}

src_install() {
	cd ${WORKDIR}
	java-pkg_dojar jta.jar
}

