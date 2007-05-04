# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxp/jaxp-1.4.ebuild,v 1.2 2007/05/04 18:21:54 nelchael Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="The Java API for XML Processing (JAXP)"
HOMEPAGE="https://jaxp.dev.java.net/"
SRC_URI="https://jaxp-sources.dev.java.net/files/documents/2779/42920/JAXP_14_FCS.class"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/jaxp-1_4-20061026"

src_unpack() {

	cd "${WORKDIR}"
	echo "A" | java -cp "${DISTDIR}" JAXP_14_FCS -console > /dev/null || die "unpack failed"

	cd "${S}"
	rm -v lib/*.jar
	unpack ./jaxp-api.src.zip || die

	cp "${FILESDIR}/build.xml-${PV}" "${S}/build.xml" -i || die "cp failed"

}

src_compile() {
	eant jar #bundled javadocs but no build.xml to generate
}

src_install() {
	java-pkg_dojar jaxp-api.jar
	java-pkg_dojar jaxp-impl.jar

	use source && java-pkg_dosrc jaxp-1_4-api/src/{javax,org}
	dodoc \
		docs/JAXP-Compatibility.html \
		docs/ReleaseNotes.html || die
	use doc && java-pkg_dojavadoc docs/api

}
