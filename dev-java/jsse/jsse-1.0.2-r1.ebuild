# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsse/jsse-1.0.2-r1.ebuild,v 1.4 2001/12/17 00:27:58 karltk Exp $

At=jsse-1_0_2-gl.zip
S=${WORKDIR}/jsse1.0.2
DESCRIPTION="Java Secure Socket Extenstions"
SRC_URI=""
HOMEPAGE="http://java.sun.com/products/jsse/"

DEPEND=">=virtual/jdk-1.3.0
	>=app-arch/unzip-5.41"
RDEPEND=">=virtual/jre-1.3.0"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE} into ${DISTDIR}"
	fi
	${JAVA_HOME}/bin/jar -xf ${DISTDIR}/${At} || die
}

src_install() {                               
	insinto /usr/share/jsse/lib
	doins lib/*.jar

	dodoc *.txt 
	dohtml *.html
	dohtml -r doc/*
	
	ls ${D}/usr/share/jsse/lib/*.jar | tr '\n' ':' \
		> ${D}/usr/share/jsse/classpath.env
	dosed /usr/share/jsse/classpath.env
	
	dodir /etc/env.d
	echo "JSSE_HOME=/usr/share/jsse" > ${D}/etc/env.d/21jsse
}



