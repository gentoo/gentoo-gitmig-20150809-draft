# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/quanta-docs/quanta-docs-1.0.ebuild,v 1.4 2002/05/27 17:27:34 drobbins Exp $

S=${WORKDIR}
DESCRIPTION="Lots of docs for quanta"

list="quanta-css-${PV}.tar.bz2 
   quanta-html-${PV}.tar.bz2 
   quanta-javascript-${PV}.tar.bz2
   quanta-php-${PV}.tar.bz2"
  
for x in $list; do
    SRC_URI="$SRC_URI mirror://sourceforge/quanta/$x"
done

HOMEPAGE="http://quanta.sourceforge.net"

src_install () {

    dodir /usr/share/apps/quanta/doc
    for i in css html javascript php
    do
      cd ${S}/${i}
      cp -R $i $i.docrc ${D}/usr/share/apps/quanta/doc    
    done

}

