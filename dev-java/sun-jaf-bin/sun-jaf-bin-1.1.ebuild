# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaf-bin/sun-jaf-bin-1.1.ebuild,v 1.4 2007/07/11 19:58:38 mr_bones_ Exp $

inherit java-pkg-2

At="jaf-1_1-fr.zip"
DESCRIPTION="Sun's JavaBeans Activation Framework (JAF)"
SRC_URI="${At}"
HOMEPAGE="http://java.sun.com/products/javabeans/glasgow/jaf.html"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
LICENSE="sun-bcla-jaf"
SLOT="0"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.4"
IUSE="doc"
RESTRICT="fetch"
S=${WORKDIR}/jaf-${PV}

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit ${HOMEPAGE}"
	einfo " 2. Download ${At}"
	einfo " 3. Move file to ${DISTDIR}"
	einfo
}

src_compile() { :; }

src_install() {
	dodoc RELNOTES.txt README.txt LICENSE.txt
	use doc && java-pkg_dohtml -r docs/
	java-pkg_dojar activation.jar
}
