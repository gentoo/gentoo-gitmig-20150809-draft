# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-javamail-bin/sun-javamail-bin-1.4.ebuild,v 1.3 2006/12/07 22:46:18 flameeyes Exp $

inherit java-pkg-2 versionator

MY_PN="javamail"
MY_PV="$(replace_all_version_separators _)"
MY_P="${MY_PN}-${MY_PV}"
At="${MY_P}.zip"

S="${WORKDIR}/${MY_PN}-$(replace_version_separator 3 _)"
DESCRIPTION="A Java-based framework to build multiplatform mail and messaging applications."
SRC_URI="${At}"
HOMEPAGE="http://java.sun.com/products/javamail/index.html"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
LICENSE="sun-bcla-javamail"
SLOT="0"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.2
	>=dev-java/sun-jaf-bin-1.0.2"
IUSE="doc"
DEP_APPEND="sun-jaf-bin"
RESTRICT="fetch"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=javamail-1.4-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit ${HOMEPAGE}"
	einfo "   Direct link: ${DOWNLOAD_URL}"
	einfo " 2. Download ${At}"
	einfo " 3. Move file to ${DISTDIR}"
	einfo
}

src_unpack() {
	unzip -qq ${DISTDIR}/${At} || die "failed too unpack"
}

src_install() {
	dodoc CHANGES.txt README.txt NOTES.txt
	use doc && java-pkg_dohtml -r docs/
	java-pkg_dojar mail.jar lib/*.jar
}
