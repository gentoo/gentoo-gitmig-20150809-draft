# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jndi/jndi-1.2.1-r2.ebuild,v 1.2 2001/12/15 01:20:18 karltk Exp $

Arse=jndi1_2_1.zip
P=jndi-1.2.1
S=${WORKDIR}/${P}
DESCRIPTION="Java Naming and Directory Interface"
HOMEPAGE="http://java.sun.com/products/jndi/"
#SRC_URI="" 
#error:You must download ${A} from $HOMEPAGE yourself"

DEPEND=">=virtual/jdk-1.2"

src_unpack() {
	echo ${Arse}
	if [ ! -f ${DISTDIR}/${Arse} ] ; then
		echo "!!! You must download ${Arse} from ${HOMEPAGE} yourself"
		die
	fi
	mkdir ${S}
	cd ${S}
	${JAVA_HOME}/bin/jar -xf ${DISTDIR}/${Arse}
}

src_compile() {                           
	cd ${S}
}

src_install() {                               
	insinto /usr/share/jndi
	doins lib/jndi.jar
	dodoc COPYRIGHT README.txt 
	dohtml -r doc/*
	echo "/usr/share/jndi/jndi.jar" > /usr/share/jndi/classpath.env
}



