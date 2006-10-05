# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdom/jdom-1.0_beta10-r4.ebuild,v 1.3 2006/10/05 17:37:05 gustavoz Exp $

inherit java-pkg-2 java-ant-2

MY_PN="jdom"
MY_PV="b10"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Java API to manipulate XML data"
SRC_URI="http://www.jdom.org/dist/source/${MY_P}.tar.gz"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="${PV}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"
RDEPEND=">=virtual/jre-1.4
		dev-java/saxpath
		dev-java/xalan
		>=dev-java/xerces-2.6.2-r1"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant-core
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

src_compile() {

	eant package || die "compile problem"

}

src_install() {
	java-pkg_dojar build/*.jar

	dodoc CHANGES.txt COMMITTERS.txt README.txt TODO.txt
	use doc && java-pkg_dohtml -r build/apidocs/*
	use source && java-pkg_dosrc src/java/*
}

pkg_postinst() {
	if ! has_version '=dev-java/jaxen-1.1*'; then
		einfo ""
		einfo "If you want jaxen support for jdom then"
		einfo "please emerge =dev-java/jaxen-1.1* first and"
		einfo "re-emerge jdom.  Sorry for the"
		einfo "inconvenience, this is to break out of the"
		einfo "circular dependencies."
		einfo ""
	fi
}
