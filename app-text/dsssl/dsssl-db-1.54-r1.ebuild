# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dsssl/dsssl-db-1.54-r1.ebuild,v 1.1 2000/08/07 15:31:45 achim Exp $

P=dsssl-db-1.54
A=db154.zip
S=${WORKDIR}/${P}
CATEGORY="app-text"
DESCRIPTION="DSSSL stylesheets fot DocBook DTD"
SRC_URI="http://nwalsh.com/docbook/dsssl/"${A}
HOMEPAGE="http://www.nwalsh.com/docbook/dsssl/index.html"

src_unpack() {
  mkdir ${S}
  cd ${S}
  unzip ${DISTDIR}/${A}
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${S}/docbook
  into /usr
  chmod +x bin/collateindex.pl
  dobin bin/collateindex.pl
  insinto /usr/share/sgml/stylesheets/docbook
  doins docbook.dcl catalog
  for i in common contrib dtds frames html images lib olink print 
  do
    cp -af  $i ${D}/usr/share/sgml/stylesheets/docbook
  done
  dodoc BUGS ChangeLog README TODO VERSION WhatsNew
  cp -af test ${D}/usr/doc/${P}

}



