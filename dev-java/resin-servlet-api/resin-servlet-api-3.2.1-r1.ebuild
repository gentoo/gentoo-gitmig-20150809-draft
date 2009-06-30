# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/resin-servlet-api/resin-servlet-api-3.2.1-r1.ebuild,v 1.3 2009/06/30 21:05:41 fauli Exp $

JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Resin Servlet API 2.5/JSP API 2.1 implementation"
HOMEPAGE="http://www.caucho.com/"
SRC_URI="http://www.caucho.com/download/resin-${PV}-src.zip
	mirror://gentoo/resin-gentoo-patches-${PV}-r1.tar.bz2"

LICENSE="GPL-2"
SLOT="2.5"
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~x86-fbsd"

IUSE=""

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"

S="${WORKDIR}/resin-${PV}"

src_unpack() {

	unpack ${A}

	mkdir "${S}/lib"

	cd "${S}"
	epatch "${WORKDIR}/${PV}/resin-${PV}-build.xml.patch" || die
	java-ant_bsfix_files build-common.xml || die

}

EANT_BUILD_TARGET="jsdk"
EANT_DOC_TARGET=""

src_install() {

	java-pkg_newjar "modules/jsdk/dist/jsdk-16.jar"
	use source && java-pkg_dosrc "${S}"/modules/jsdk/src/*

	dosym "${PN}.jar" "/usr/share/${PN}-${SLOT}/lib/servlet-api.jar"
	java-pkg_regjar "${D}/usr/share/${PN}-${SLOT}/lib/servlet-api.jar"
	dosym "${PN}.jar" "/usr/share/${PN}-${SLOT}/lib/jsp-api.jar"
	java-pkg_regjar "${D}/usr/share/${PN}-${SLOT}/lib/jsp-api.jar"

}
