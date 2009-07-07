# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmf-bin/jmf-bin-2.1.1e-r2.ebuild,v 1.6 2009/07/07 23:02:09 flameeyes Exp $

inherit java-pkg-2

At="${PN%-bin}-2_1_1e-alljava.zip"
S="${WORKDIR}/JMF-${PV}"
DESCRIPTION="The Java Media Framework API (JMF)"
SRC_URI="${At}"
HOMEPAGE="http://java.sun.com/products/java-media/jmf/"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
LICENSE="sun-bcla-jmf"
SLOT="0"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.4"
RESTRICT="fetch"
DOWNLOAD_URL="https://cds.sun.com/is-bin/INTERSHOP.enfinity/WFS/CDS-CDS_Developer-Site/en_US/-/USD/ViewProductDetail-Start?ProductRef=7372-jmf-2.1.1e-oth-JPR@CDS-CDS_Developer"

pkg_nofetch() {
	elog
	elog " Due to license restrictions, we cannot fetch the"
	elog " distributables automagically."
	elog
	elog " 1. Visit ${DOWNLOAD_URL} and select 'Linux'"
	elog " 2. Download ${At}"
	elog " 3. Move file to ${DISTDIR}"
	elog " 4. Run emerge on this package again to complete"
	elog
}

src_unpack() {
	unzip -qq "${DISTDIR}"/${At} || die
}

src_install() {
	dobin \
		"${FILESDIR}"/jmfcustomizer \
		"${FILESDIR}"/jmfinit \
		"${FILESDIR}"/jmfregistry \
		"${FILESDIR}"/jmstudio
	dohtml "${S}"/doc/*.html
	java-pkg_dojar "${S}"/lib/*.jar
	insinto /usr/share/${PN}/lib
	doins lib/jmf.properties
}
