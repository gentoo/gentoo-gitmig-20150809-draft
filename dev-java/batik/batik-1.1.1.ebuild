# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/batik/batik-1.1.1.ebuild,v 1.1 2003/04/27 08:06:25 tberman Exp $

S=${WORKDIR}/xml-batik
DESCRIPTION="Batik is a Java(tm) technology based toolkit for applications or applets that want to use images in the Scalable Vector Graphics (SVG) format for various purposes, such as viewing, generation or manipulation."
SRC_URI="http://xml.apache.org/batik/dist/${PN}-src-${PV}.zip"
HOMEPAGE="http://xml.apache.org/batik/"
IUSE=""
DEPEND=">=virtual/jdk-1.3
	dev-java/ant"
REDEPND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

src_unpack() {
	jar xvf ${DISTDIR}/${PN}-src-${PV}.zip
}

src_compile() {
	ant dist-zip || die
}

src_install () {

	# Need to fix up some documentation + USE vars, but I want
        # to put this in, as it appears to work as far as I can tell
	dojar ${P}/batik*.jar
	dojar ${P}/lib/*.jar
	
	dodoc README LICENSE LICENSE.rhino
	dohtml -r ${P}/docs/
}
