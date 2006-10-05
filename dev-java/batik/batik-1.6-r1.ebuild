# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/batik/batik-1.6-r1.ebuild,v 1.2 2006/10/05 15:09:37 gustavoz Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java based toolkit for applications or applets that want to use images in the Scalable Vector Graphics (SVG) format for various purposes, such as viewing, generation or manipulation."
HOMEPAGE="http://xml.apache.org/batik/"
SRC_URI="mirror://apache/xml/batik/${PN}-src-${PV}.zip"

LICENSE="Apache-2.0"
SLOT="1.6"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

CDEPEND="=dev-java/rhino-1.5*
	>=dev-java/xerces-2.7.1
	=dev-java/xml-commons-external-1.3*"
DEPEND="=virtual/jdk-1.4*
	dev-java/ant-core
	app-arch/unzip
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"

S="${WORKDIR}/xml-${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${P}-jikes.patch

	cd lib
	rm -f *.jar build/*.jar

	java-pkg_jar-from xml-commons-external-1.3
	java-pkg_jar-from xerces-2
	java-pkg_jar-from rhino-1.5
}

src_compile() {
	# Fails to build on amd64 without this
	if use amd64 ; then
		export ANT_OPTS="-Xmx1g"
	else
		export ANT_OPTS="-Xmx256m"
	fi

	eant jars all-jar $(use_doc)
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
	use doc && java-pkg_dohtml -r ${P}/docs/api xdocs/*

	# pwd fixes bug #116976
	java-pkg_dolauncher batik-${SLOT} --pwd "/usr/share/${PN}-${SLOT}/" \
		--main org.apache.batik.apps.svgbrowser.Main
}
