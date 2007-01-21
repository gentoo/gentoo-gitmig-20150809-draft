# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr181/jsr181-0.7.ebuild,v 1.3 2007/01/21 18:07:55 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JSR 181 Web Services Metadata"
HOMEPAGE="http://jcp.org/aboutJava/communityprocess/edr/jsr181/index.html"
SRC_URI="web_svcs_md-0_7-erd-spec.zip"

LICENSE="bea.jsr181"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc source"
RESTRICT="fetch nostrip"

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
	unzip -qq jsr181-src.jar || die "unzip failed"
	mkdir src lib
	mv javax src

	cp "${FILESDIR}/build.xml" "${S}/"

}

src_compile() {

	cd "${S}"
	local antflags="jar"
	use doc && antflags="${antflags} doc"
	eant ${antflags}

}

src_install() {

	cd "${S}"
	java-pkg_dojar jsr181.jar

	use doc && {
		java-pkg_dohtml -r api
		dodoc JSR181-ERD4.pdf
	}
	use source && java-pkg_dosrc "src/*"

}
