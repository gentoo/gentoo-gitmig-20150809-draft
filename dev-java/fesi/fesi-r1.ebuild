# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/fesi/fesi-r1.ebuild,v 1.1 2000/08/07 17:43:40 achim Exp $

P=fesi
A="fesikit.zip"
S=${WORKDIR}/${P}
CATEGORY="dev-java"
DESCRIPTION="JavaScript Interpreter writte in Java"
SRC_URI="http://home.worldcom.ch/jmlugrin/fesi/fesikit.zip"

src_unpack() {
  jar -xf ${DISTDIR}/fesisrc.zip
  jar -xf ${DISTDIR}/fesikit.zip
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${S}
  insinto /opt/java/lib
  doins fesi.jar
  into /usr
  dodoc COPYRIGHT.TXT Readme.txt 
  docinto html
  dodoc doc/html/*.html doc/html/*.gif doc/html/*.txt
  docinto html/api
  dodoc doc/html/api/*.html doc/html/api/*.css
  for i in AST awtgui ClassFile Data Exceptions Extensions Interpreter jslib Parser Tests
  do
    docinto html/api/FESI/$i
    dodoc doc/Design/api/FESI/$i/*.html
  done


}




