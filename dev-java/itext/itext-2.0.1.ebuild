# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/itext/itext-2.0.1.ebuild,v 1.3 2007/04/03 10:26:39 caster Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java library that generate documents in the Portable Document Format (PDF) and/or HTML."
HOMEPAGE="http://www.lowagie.com/iText/"
SRC_URI="mirror://sourceforge/itext/${PN}-src-${PV}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND=">=dev-java/bcmail-1.36
	>=dev-java/bcprov-1.36"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"

S=${WORKDIR}

src_unpack() {
	mkdir "${WORKDIR}/src" && cd "${WORKDIR}/src"
	unpack ${A}

	epatch ${FILESDIR}/${PV}-compile_xml.patch
	epatch ${FILESDIR}/${PV}-site_xml.patch
	java-ant_bsfix_files ant/*.xml || die "failed to rewrite build xml files"

	mkdir -p "${WORKDIR}/build/bin" || die
	cd "${WORKDIR}/build/bin" || die
	java-pkg_jar-from bcmail bcmail.jar bcmail-jdk14-135.jar
	java-pkg_jar-from bcprov bcprov.jar bcprov-jdk14-135.jar
}

EANT_BUILD_XML="src/build.xml"

src_install() {
	java-pkg_dojar build/bin/iText.jar

	use source && java-pkg_dosrc src/com
	use doc && java-pkg_dojavadoc build/docs
}
