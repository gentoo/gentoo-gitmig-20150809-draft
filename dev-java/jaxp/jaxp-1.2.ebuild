# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxp/jaxp-1.2.ebuild,v 1.1 2002/01/15 14:45:06 gbevin Exp $

At=java_xml_pack-winter01-dev.zip
S=${WORKDIR}/java_xml_pack-winter-01-dev
DESCRIPTION="Java API for XML parsing"
SRC_URI=""
HOMEPAGE="http://java.sun.com/xml/"

DEPEND=">=virtual/jdk-1.3
	>=app-arch/unzip-5.41"

RDEPEND=">=virtual/jdk-1.3"


src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		echo "!!! Please download ${At} from ${HOMEPAGE}"
		die
	fi
	${JAVA_HOME}/bin/jar -xf ${DISTDIR}/${At}
}

src_install() {                      
	cd ${S}
	insinto /usr/share/jaxp
	doins jaxp-1.2-ea1/xerces.jar jaxp-1.2-ea1/xalan.jar
	dohtml -r jaxp-1.2-ea1/docs/*
	echo "/usr/share/jaxp/xerces.jar:/usr/share/jaxp/xalan.jar" \
		> ${D}/usr/share/jaxp/classpath.env
}



