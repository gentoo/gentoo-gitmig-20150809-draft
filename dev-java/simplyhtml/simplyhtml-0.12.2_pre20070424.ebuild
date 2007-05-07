# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/simplyhtml/simplyhtml-0.12.2_pre20070424.ebuild,v 1.1 2007/05/07 12:47:54 caster Exp $

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2 versionator

# the commented out stuff is for upsteam release

#MY_PN="shtml"
#MY_PV="$(replace_all_version_separators _)"
#MY_P="${MY_PN}_${MY_PV}"

DESCRIPTION="Text processing application based on HTML and CSS files."
HOMEPAGE="http://${PN}.sourceforge.net"
#SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

COMMON_DEP="dev-java/javahelp
	dev-java/gnu-regexp"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
#	app-arch/unzip
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

#S="${WORKDIR}/dist"

src_unpack() {
	unpack ${A}
	cd "${S}"

#	rm -rf api || die
#	rm -v lib/*.jar || die
}

src_compile() {
	cd src || die
	local cp="$(java-pkg_getjars javahelp,gnu-regexp-1)"
	eant -Dclasspath="${cp}" jar $(use_doc)
}

src_install() {
	java-pkg_dojar dist/lib/*.jar

	use doc && java-pkg_dojavadoc dist/api
	use source && java-pkg_dosrc src/com src/de
}
