# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmf-bin/jmf-bin-2.1.1e-r2.ebuild,v 1.1 2007/04/03 13:51:11 fordfrog Exp $

inherit java-pkg-2

At="${PN%-bin}-2_1_1e-alljava.zip"
S="${WORKDIR}/JMF-${PV}"
DESCRIPTION="The Java Media Framework API (JMF) enables audio, video and other time-based media to be added to Java applications and applets."
SRC_URI="${At}"
HOMEPAGE="http://java.sun.com/products/java-media/jmf/"
KEYWORDS="~amd64 ~ppc ~x86"
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
