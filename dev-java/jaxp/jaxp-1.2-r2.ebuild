# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxp/jaxp-1.2-r2.ebuild,v 1.1 2002/06/24 22:20:39 karltk Exp $

S=${WORKDIR}/java_xml_pack-spring-02-dev
DESCRIPTION="Java API for XML parsing"
SRC_URI="ftp://ftp.java.sun.com/pub/xml/msowe93ls/java_xml_pack-spring02-dev.zip"
HOMEPAGE="http://java.sun.com/xml/"
RESTRICT="nomirror"
LICENSE="ReallyNasty"
DEPEND=">=virtual/jdk-1.3
	>=app-arch/unzip-5.41"
RDEPEND=">=virtual/jdk-1.3"
SLOT="1.2"

src_install() {                      
	cd ${S}
	dojar jaxp-1.2-ea1/xerces.jar jaxp-1.2-ea1/xalan.jar
	dohtml -r jaxp-1.2-ea1/docs/*

	einfo "!!! Beware that this package has a _very_ restrictive license!"
}



