# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxp/jaxp-1.1.3.ebuild,v 1.3 2002/07/11 06:30:19 drobbins Exp $

At=java_xml_pack-winter01.zip
S=${WORKDIR}/java_xml_pack-winter01
DESCRIPTION="Java API for XML parsing"
SRC_URI=""
HOMEPAGE="http://java.sun.com/xml/"

DEPEND=">=virtual/jdk-1.3
	>=app-arch/unzip-5.41"

RDEPEND=">=virtual/jdk-1.3"


src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "!!! Please download ${At} from ${HOMEPAGE}"
	fi
	jar -xf ${DISTDIR}/${At}
}

src_install() {                
	dojar jaxp-1.1.3/crimson.jar jaxp-1.1.3/xalan.jar
	dohtml -r jaxp-1.1.3/docs/*
	cp -r jaxp-1.1.3/examples ${D}/usr/share/doc/${PF}/
}



