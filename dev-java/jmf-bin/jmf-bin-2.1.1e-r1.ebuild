# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmf-bin/jmf-bin-2.1.1e-r1.ebuild,v 1.6 2008/01/05 23:24:03 betelgeuse Exp $

inherit java-pkg

At="${PN%-bin}-2_1_1e-alljava.zip"
S="${WORKDIR}/JMF-${PV}"
DESCRIPTION="The Java Media Framework API (JMF)"
SRC_URI="${At}"
HOMEPAGE="http://java.sun.com/products/java-media/jmf/"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""
LICENSE="sun-bcla-jmf"
SLOT="0"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.4"
RESTRICT="fetch"

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit ${HOMEPAGE} and select 'Cross Platform Java'"
	einfo " 2. Download ${At}"
	einfo " 3. Move file to ${DISTDIR}"
	einfo " 4. Run emerge on this package again to complete"
	einfo
}

src_unpack() {
	unzip -qq ${DISTDIR}/${At} || die
}

src_install() {
	dobin \
		${FILESDIR}/jmfcustomizer \
		${FILESDIR}/jmfinit \
		${FILESDIR}/jmfregistry \
		${FILESDIR}/jmstudio
	dohtml ${S}/doc/*.html
	java-pkg_dojar ${S}/lib/*.jar
	insinto /usr/share/${PN}/lib
	doins lib/jmf.properties
}
