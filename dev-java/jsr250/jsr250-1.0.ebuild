# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr250/jsr250-1.0.ebuild,v 1.1 2006/09/11 11:46:40 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JSR 250 Common Annotations"
HOMEPAGE="http://jcp.org/en/jsr/detail?id=250"
SRC_URI="com_annotations-1_0-fr-api-doc.zip"

LICENSE="sun-jsr250"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"
RESTRICT="fetch nostrip"

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}"

pkg_nofetch() {

	einfo "Please go to following URL:"
	einfo " http://jcp.org/aboutJava/communityprocess/final/jsr250/index.html"
	einfo "download file named com_annotations-1_0-fr-api-doc.zip and place it in:"
	einfo " ${DISTDIR}"

}

src_install() {

	cd "${S}"
	java-pkg_dojar lib/jsr250-api.jar

	use doc && java-pkg_dohtml -r docs/api

}
