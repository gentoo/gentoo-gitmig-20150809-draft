# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdom/jdom-1.0_beta9-r2.ebuild,v 1.6 2007/05/25 09:24:07 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

IUSE="doc source"

MY_PN="jdom"
MY_PV="b9"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Java API to manipulate XML data"
SRC_URI="http://www.jdom.org/dist/source/${MY_P}.tar.gz"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND=">=virtual/jre-1.4
		dev-java/saxpath
		dev-java/xalan
		>=dev-java/xerces-2.7"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f build/*.jar lib/*.jar

	cd ${S}/lib
	java-pkg_jar-from saxpath
	java-pkg_jar-from xerces-2

	if has_version '=dev-java/jaxen-1.1*'; then
		java-pkg_jar-from jaxen-1.1
	fi
}

EANT_BUILD_TARGET="package"
EANT_DOC_TARGET=""
# to prevent a newer jdom from going into cp
ANT_TASKS="none"

src_install() {
	java-pkg_dojar build/*.jar

	dodoc CHANGES.txt COMMITTERS.txt README.txt TODO.txt
	use doc && java-pkg_dohtml -r build/apidocs/*
	use source && java-pkg_dosrc src/java/*
}

pkg_postinst() {
	if ! has_version '=dev-java/jaxen-1.1*'; then
		elog ""
		elog "If you want jaxen support for jdom then"
		elog "please emerge =dev-java/jaxen-1.1* first and"
		elog "re-emerge jdom.  Sorry for the"
		elog "inconvenience, this is to break out of the"
		elog "circular dependencies."
		elog ""
	fi
}
