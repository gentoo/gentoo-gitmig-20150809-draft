# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxp/jaxp-1.1.3.ebuild,v 1.1 2001/12/15 01:43:43 karltk Exp $

At=java_xml_pack-fall01.zip
S=${WORKDIR}/java_xml_pack-fall01
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
	insinto /usr/share/jaxp
	doins jaxp-1.1.3/crimson.jar jaxp-1.1.3/xalan.jar
	dohtml -r jaxp-1.1.3/docs/*
	cp -r jaxp-1.1.3/examples ${D}/usr/share/doc/${PF}/
	echo "/usr/share/jaxp/crimson.jar:/usr/share/jaxp/xalan.jar" \
		> ${D}/usr/share/jaxp/classpath.env
}



