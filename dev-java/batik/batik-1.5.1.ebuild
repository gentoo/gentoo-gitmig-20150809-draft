# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/batik/batik-1.5.1.ebuild,v 1.3 2004/11/03 11:22:47 axxo Exp $

inherit java-pkg

DESCRIPTION="Batik is a Java(tm) technology based toolkit for applications or applets that want to use images in the Scalable Vector Graphics (SVG) format for various purposes, such as viewing, generation or manipulation."
SRC_URI="mirror://apache/xml/batik/${PN}-src-${PV}.zip"
HOMEPAGE="http://xml.apache.org/batik/"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3
		app-arch/unzip
		dev-java/ant"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~sparc ppc"

S=${WORKDIR}/xml-batik

src_unpack() {
	jar xvf ${DISTDIR}/${PN}-src-${PV}.zip
}

src_compile() {
	local antflags="jars"
	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar ${P}/batik*.jar
	insinto /usr/share/${PN}/lib/lib
	doins ${P}/lib/*.jar

	dodoc README LICENSE
	use doc && java-pkg_dohtml -r ${P}/docs/
}
