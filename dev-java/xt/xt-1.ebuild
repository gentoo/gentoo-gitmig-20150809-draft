# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt/xt-1.ebuild,v 1.5 2002/01/23 20:06:16 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="ftp://ftp.jclark.com/pub/xml/${PN}.zip"

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



