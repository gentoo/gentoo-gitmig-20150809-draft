# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/itext/itext-2.0.0.ebuild,v 1.2 2007/03/23 13:12:26 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java library that generate documents in the Portable Document Format (PDF) and/or HTML."
HOMEPAGE="http://www.lowagie.com/iText/"
SRC_URI="mirror://sourceforge/itext/${PN}-src-${PV}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	mkdir "${WORKDIR}/src" && cd "${WORKDIR}/src"
	unpack ${A}

	# Tries to download these in the compile target
	# with the get task so we should do something to it
	# before this can do stable
	#mkdir -p "${WORKDIR}/build/bin" || die
	#cd "${WORKDIR}/build/bin" || die
	#touch foo.txt
	#jar cf bcmail-jdk14-135.jar foo.txt
	#jar cf bcprov-jdk14-135.jar foo.txt
}

EANT_BUILD_XML="src/build.xml"

src_install() {
	java-pkg_dojar build/bin/*.jar

	use source && java-pkg_dosrc src/com
	use doc && java-pkg_dojavadoc build/docs
}
