# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/batik/batik-1.5.1-r3.ebuild,v 1.3 2005/03/19 23:48:11 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Batik is a Java(tm) technology based toolkit for applications or applets that want to use images in the Scalable Vector Graphics (SVG) format for various purposes, such as viewing, generation or manipulation."
SRC_URI="mirror://apache/xml/batik/${PN}-src-${PV}.zip"
HOMEPAGE="http://xml.apache.org/batik/"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3
		=dev-java/rhino-1.5*
		dev-java/fop
		app-arch/unzip
		>=dev-java/xerces-2.6.2-r1
		dev-java/ant"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="1.5.1"
KEYWORDS="x86 ~sparc ~ppc"

S=${WORKDIR}/xml-batik

src_unpack() {
	jar xvf ${DISTDIR}/${PN}-src-${PV}.zip
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from xerces-2
	java-pkg_jar-from rhino-1.5
	java-pkg_jar-from fop
}

src_compile() {
	if [ $(memory) -lt 262144 ] ; then
		echo
		ewarn "To build batik, atleast 256MB of RAM is recommended."
		ewarn "Your system has less than 256MB of RAM, continuing anyways."
		echo

		export ANT_OPTS=-Xmx256m
	fi

	local antflags="jars"
	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar ${P}/batik*.jar
	insinto /usr/share/${PN}-${SLOT}/lib/lib
	doins ${P}/lib/batik*.jar

	dodoc README LICENSE
	use doc && java-pkg_dohtml -r ${P}/docs/

	echo "#!/bin/sh" > ${PN}
	echo '${JAVA_HOME}/bin/java -classpath $(java-config -p batik-1.5.1,xerces-2,rhino-1.5,fop) org.apache.batik.apps.svgbrowser.Main $*' >> ${PN}
	dobin ${PN}

}

function memory() {
	cat /proc/meminfo | grep Memtotal | sed -r "s/[^0-9]*([0-9]+).*/\1/"
}
