# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt/xt-1.ebuild,v 1.8 2002/08/01 16:46:58 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="ftp://ftp.jclark.com/pub/xml/${PN}.zip"
LICENSE="JamesClark"
SLOT="1"
KEYWORDS="x86"
DEPEND=">=virtual/jdk-1.2.2"

src_unpack() {
	mkdir ${S}
	cd ${S}
	jar -xf ${DISTDIR}/${PN}.zip
}

src_install() {              
	dojar xt.jar sax.jar
	dohtml xt.html
	docinto demo
	dodoc demo/*
}



