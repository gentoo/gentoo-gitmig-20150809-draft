# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr181/jsr181-0.7.ebuild,v 1.4 2007/03/18 18:06:26 nelchael Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JSR 181 Web Services Metadata"
HOMEPAGE="http://jcp.org/aboutJava/communityprocess/edr/jsr181/index.html"
SRC_URI="web_svcs_md-0_7-erd-spec.zip"

LICENSE="bea.jsr181"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""
RESTRICT="fetch"

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}"

pkg_nofetch() {

	einfo "Please go to following URL:"
	einfo " ${HOMEPAGE}"
	einfo "download file named web_svcs_md-0_7-erd-spec.zip and place it in:"
	einfo " ${DISTDIR}"

}

src_unpack() {

	unpack "${A}"
	cd "${S}"
	unpack ./jsr181-src.jar
	rm -f jsr181-src.jar
	mkdir src lib || die
	mv javax src || die

	cp -i "${FILESDIR}/build.xml" "${S}/" || die

}

EANT_DOC_TARGET="doc"

src_install() {

	java-pkg_dojar jsr181.jar

	use doc && {
		java-pkg_dojavadoc api
		dodoc JSR181-ERD4.pdf
	}
	use source && java-pkg_dosrc src/*

}
