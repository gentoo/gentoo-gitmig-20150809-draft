# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsse/jsse-1.0.2-r1.ebuild,v 1.6 2002/07/11 06:30:19 drobbins Exp $

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
	jar -xf ${DISTDIR}/${At} || die
}

src_install() {                               
	dojar lib/*.jar

	dodoc *.txt 
	dohtml *.html
	dohtml -r doc/*
	
	dodir /etc/env.d
	echo "JSSE_HOME=/usr/share/jsse" > ${D}/etc/env.d/21jsse
}



