# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/batik/batik-1.5.1-r4.ebuild,v 1.8 2005/08/26 13:15:33 flameeyes Exp $

inherit java-pkg

DESCRIPTION="Batik is a Java(tm) technology based toolkit for applications or applets that want to use images in the Scalable Vector Graphics (SVG) format for various purposes, such as viewing, generation or manipulation."
HOMEPAGE="http://xml.apache.org/batik/"
SRC_URI="mirror://apache/xml/batik/${PN}-src-${PV}.zip"

LICENSE="Apache-1.1"
SLOT="1.5.1"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc"

RDEPEND=">=virtual/jre-1.3
	=dev-java/rhino-1.5*
	=dev-java/xerces-2.6*
	dev-java/xml-commons"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	app-arch/unzip
	dev-java/ant-core"

S=${WORKDIR}/xml-batik

src_unpack() {
	unzip -q ${DISTDIR}/${A}

	cd ${S}/lib && rm -f *.jar
	java-pkg_jar-from rhino-1.5
	java-pkg_jar-from xerces-2
}

src_compile() {
	export ANT_OPTS=-Xmx256m
	local antflags="jars all-jar"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar ${P}/batik*.jar

	cd ${P}/lib
	rm {js,x*}.jar

	# needed because batik expects this layout:
	# batik.jar lib/*.jar
	# there are hardcoded classpathes in the manifest :(
	for jar in *.jar
	do
		java-pkg_dojar ${jar}
		rm -f ${jar}
		ln -s ${DESTTREE}/share/${PN}-${SLOT}/lib/${jar} ${jar}
	done

	cd ${S}
	cp -pPR ${P}/lib ${D}${DESTTREE}/share/${PN}-${SLOT}/lib/

	dodoc README
	use doc && java-pkg_dohtml -r ${P}/docs/

	echo "#!/bin/sh" > ${PN}${SLOT}
	echo '${JAVA_HOME}/bin/java -classpath $(java-config -p batik-1.5.1,xerces-2,xml-commons,rhino-1.5) org.apache.batik.apps.svgbrowser.Main $*' >> ${PN}${SLOT}
	dobin ${PN}${SLOT}

}
