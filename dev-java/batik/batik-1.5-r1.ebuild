# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/batik/batik-1.5-r1.ebuild,v 1.8 2007/02/14 10:42:29 corsair Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java based toolkit for applications or applets that want to use images in the Scalable Vector Graphics (SVG) format for various purposes, such as viewing, generation or manipulation."
SRC_URI="mirror://gentoo/${PN}-src-${PV}.zip"
HOMEPAGE="http://xml.apache.org/batik/"
IUSE="doc"
LICENSE="Apache-1.1"
SLOT="1.5"
KEYWORDS="amd64 ~ia64 ppc ~ppc64 x86"

CDEPEND="=dev-java/rhino-1.5*
	>=dev-java/xerces-2.7.1
	=dev-java/xml-commons-external-1.3*
	dev-java/jython"
DEPEND="=virtual/jdk-1.4*
	dev-java/ant-core
	app-arch/unzip
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"

S="${WORKDIR}/xml-${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}/lib"

	rm -f *.jar build/*.jar

	java-pkg_jar-from xml-commons-external-1.3
	java-pkg_jar-from xerces-2
	java-pkg_jar-from rhino-1.5
	java-pkg_jar-from jython
}

src_compile() {
	java-pkg_filter-compiler jikes
	ANT_OPTS=-Xmx256m eant jars all-jar
}

src_install() {
	java-pkg_dojar ${P}/batik*.jar

	cd ${P}/lib
	rm {js,x*}.jar

	# needed because batik expects this layout:
	# batik.jar lib/*.jar
	# there are hardcoded classpaths in the manifest :(
	dodir /usr/share/${PN}-${SLOT}/lib/lib/
	for jar in *.jar
	do
		java-pkg_dojar ${jar}
		rm -f ${jar}
		dosym ../${jar} /usr/share/${PN}-${SLOT}/lib/lib/${jar}
	done

	cd "${S}"
	dodoc README LICENSE || die "dodoc failed"
	use doc && java-pkg_dohtml -r ${P}/docs/

	java-pkg_dolauncher ${PN}-${SLOT} --main org.apache.batik.apps.svgbrowser.Main
}
