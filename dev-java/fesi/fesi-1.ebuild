# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/fesi/fesi-1.ebuild,v 1.5 2002/01/23 20:06:16 karltk Exp $

P=fesi
A="fesikit.zip"
S=${WORKDIR}/${P}
DESCRIPTION="JavaScript Interpreter written in Java"
SRC_URI="http://home.worldcom.ch/jmlugrin/fesi/fesikit.zip"

DEPEND=">=virtual/jre-1.2.2"

echo $PATH
src_unpack() {
	jar -xf ${DISTDIR}/fesikit.zip
}

src_compile() {                           
	cd ${S}
}

src_install() {                               

	dojar fesi.jar

	into /usr
	dodoc COPYRIGHT.TXT Readme.txt 
	dohtml -r doc/html/*
}




