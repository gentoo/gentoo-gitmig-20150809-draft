# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt/xt-1.ebuild,v 1.4 2001/12/15 02:19:52 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="ftp://ftp.jclark.com/pub/xml/${P}.zip

DEPEND=">=virtual/jdk-1.2.2"

src_unpack() {
	mkdir ${S}
	cd ${S}
	${JAVA_HOME}/bin/jar -xf ${DISTDIR}/${P}.zip
}

src_install() {                               
	insinto /usr/share/xt
	doins xt.jar sax.jar
	dohtml xt.html
	docinto demo
	dodoc demo/*
	echo "/usr/share/xt/xt.jar:/usr/share/xt/sax.jar" \
		> ${D}/usr/share/xt/classpath.env
}



